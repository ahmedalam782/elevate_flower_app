import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/change_lang/domain/repositories/change_lang_repo.dart';
import 'package:elevate_flower_app/features/change_lang/domain/use_cases/change_lang_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_lang_use_case_test.mocks.dart';

@GenerateMocks([ChangeLangRepo, BuildContext])
void main() {
  setUpAll(() {
    provideDummy<Result<void>>(const Success());
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  late ChangeLangUseCase useCase;
  late MockChangeLangRepo mockRepository;
  late MockBuildContext mockContext;

  setUp(() {
    mockRepository = MockChangeLangRepo();
    mockContext = MockBuildContext();
    useCase = ChangeLangUseCase(mockRepository);
  });

  group('call', () {
    test(
      'should call repository changeLanguage with correct parameters',
      () async {
        // Arrange
        const locale = Locale('ar');
        when(mockRepository.changeLanguage(any, any))
            .thenAnswer((_) async => const Success());

        // Act
        await useCase.call(locale: locale, context: mockContext);

        // Assert
        verify(mockRepository.changeLanguage(locale, mockContext)).called(1);
      },
    );

    test(
      'should return Success when repository returns Success',
      () async {
        // Arrange
        const locale = Locale('en');
        when(mockRepository.changeLanguage(any, any))
            .thenAnswer((_) async => const Success());

        // Act
        final result = await useCase.call(locale: locale, context: mockContext);

        // Assert
        expect(result, isA<Success<void>>());
        verify(mockRepository.changeLanguage(locale, mockContext)).called(1);
      },
    );

    test(
      'should return Error when repository returns Error',
      () async {
        // Arrange
        const locale = Locale('ar');
        final exception = Exception('Failed to change language');
        when(mockRepository.changeLanguage(any, any))
            .thenAnswer((_) async => Error(exception: exception));

        // Act
        final result = await useCase.call(locale: locale, context: mockContext);

        // Assert
        expect(result, isA<Error<void>>());
        final errorResult = result as Error<void>;
        expect(errorResult.exception, exception);
        verify(mockRepository.changeLanguage(locale, mockContext)).called(1);
      },
    );
  });
}
