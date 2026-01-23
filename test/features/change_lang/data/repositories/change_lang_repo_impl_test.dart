import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/change_lang/data/datasources/local_data_source.dart';
import 'package:elevate_flower_app/features/change_lang/data/repositories/change_lang_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_lang_repo_impl_test.mocks.dart';

@GenerateMocks([ChangeLangLocalDataSource, BuildContext])
void main() {
  setUpAll(() {
    provideDummy<Result<void>>(const Success());
    provideDummy<Result<String>>(const Success(data: 'en'));
  });
  late ChangeLangRepoImpl repository;
  late MockChangeLangLocalDataSource mockLocalDataSource;
  late MockBuildContext mockContext;

  setUp(() {
    mockLocalDataSource = MockChangeLangLocalDataSource();
    mockContext = MockBuildContext();
    repository = ChangeLangRepoImpl(mockLocalDataSource);
  });

  group('changeLanguage', () {
    test(
      'should return Success when language is changed successfully',
      () async {
        // Arrange
        const locale = Locale('ar');
        when(
          mockLocalDataSource.setLanguage(any, any),
        ).thenAnswer((_) async => const Success());

        // Act
        final result = await repository.changeLanguage(locale, mockContext);

        // Assert
        expect(result, isA<Success<void>>());
        verify(mockLocalDataSource.setLanguage(locale, mockContext)).called(1);
      },
    );

    test('should return Error when localDataSource returns Error', () async {
      // Arrange
      const locale = Locale('en');
      final exception = Exception('Failed to set language');
      when(
        mockLocalDataSource.setLanguage(any, any),
      ).thenAnswer((_) async => Error(exception: exception));

      // Act
      final result = await repository.changeLanguage(locale, mockContext);

      // Assert
      expect(result, isA<Error<void>>());
      final errorResult = result as Error<void>;
      expect(errorResult.exception, exception);
      verify(mockLocalDataSource.setLanguage(locale, mockContext)).called(1);
    });
  });

  group('getCurrentLanguage', () {
    test(
      'should return Success with language code when language is retrieved successfully',
      () async {
        // Arrange
        const languageCode = 'ar';
        when(
          mockLocalDataSource.getLanguage(),
        ).thenAnswer((_) async => const Success(data: languageCode));

        // Act
        final result = await repository.getCurrentLanguage();

        // Assert
        expect(result, isA<Success<String>>());
        final successResult = result as Success<String>;
        expect(successResult.data, languageCode);
        verify(mockLocalDataSource.getLanguage()).called(1);
      },
    );

    test('should return Error when localDataSource returns Error', () async {
      // Arrange
      final exception = Exception('Failed to get language');
      when(
        mockLocalDataSource.getLanguage(),
      ).thenAnswer((_) async => Error(exception: exception));

      // Act
      final result = await repository.getCurrentLanguage();

      // Assert
      expect(result, isA<Error<String>>());
      final errorResult = result as Error<String>;
      expect(errorResult.exception, exception);
      verify(mockLocalDataSource.getLanguage()).called(1);
    });
  });
}
