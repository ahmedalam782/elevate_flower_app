import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/change_lang/domain/repositories/change_lang_repo.dart';
import 'package:elevate_flower_app/features/change_lang/domain/use_cases/get_lang_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_lang_use_case_test.mocks.dart';

@GenerateMocks([ChangeLangRepo])
void main() {
  setUpAll(() {
    provideDummy<Result<String>>(const Success(data: 'en'));
  });
  late GetLangUseCase useCase;
  late MockChangeLangRepo mockRepository;

  setUp(() {
    mockRepository = MockChangeLangRepo();
    useCase = GetLangUseCase(mockRepository);
  });

  group('call', () {
    test(
      'should call repository getCurrentLanguage',
      () async {
        // Arrange
        const languageCode = 'ar';
        when(mockRepository.getCurrentLanguage())
            .thenAnswer((_) async => Success(data: languageCode));

        // Act
        await useCase.call();

        // Assert
        verify(mockRepository.getCurrentLanguage()).called(1);
      },
    );

    test(
      'should return Success with language code when repository returns Success',
      () async {
        // Arrange
        const languageCode = 'en';
        when(mockRepository.getCurrentLanguage())
            .thenAnswer((_) async => Success(data: languageCode));

        // Act
        final result = await useCase.call();

        // Assert
        expect(result, isA<Success<String>>());
        final successResult = result as Success<String>;
        expect(successResult.data, languageCode);
        verify(mockRepository.getCurrentLanguage()).called(1);
      },
    );

    test(
      'should return Error when repository returns Error',
      () async {
        // Arrange
        final exception = Exception('Failed to get language');
        when(mockRepository.getCurrentLanguage())
            .thenAnswer((_) async => Error(exception: exception));

        // Act
        final result = await useCase.call();

        // Assert
        expect(result, isA<Error<String>>());
        final errorResult = result as Error<String>;
        expect(errorResult.exception, exception);
        verify(mockRepository.getCurrentLanguage()).called(1);
      },
    );
  });
}
