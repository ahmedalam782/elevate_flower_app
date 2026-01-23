import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/utils/enums/gender.dart';
import 'package:elevate_flower_app/features/register/domain/entities/register_user_response.dart';
import 'package:elevate_flower_app/features/register/domain/use_cases/register_user_user_case.dart';
import 'package:elevate_flower_app/features/register/domain/use_cases/save_token_use_case.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_cubit_test.mocks.dart';

@GenerateMocks([RegisterUserUseCase, SaveTokenUseCase])
void main() {
  late RegisterCubit cubit;
  late MockRegisterUserUseCase registerUserUseCase;
  late SaveTokenUseCase saveTokenUseCase;

  setUp(() {
    registerUserUseCase = MockRegisterUserUseCase();
    saveTokenUseCase = MockSaveTokenUseCase();

    cubit = RegisterCubit(
      registerUserUseCase,
      saveTokenUseCase,
      formValidator: () => true,
    );
  });
  tearDown(() {
    cubit.close();
  });
  group("RegisterCubit", () {
    test("test if initial state is correct", () {
      expect(cubit.state, isA<RegisterStates>());
    });

    group("onGenderSelected tests", () {
      test("test updates selected gender and hides gender error", () {
        cubit.emit(
          cubit.state.copyWith(
            genderRowState: cubit.state.genderRowState.copyWith(
              showGenderError: true,
            ),
          ),
        );
        cubit.doIntent(RegisterEvents.onGenderSelected(Gender.female));
        final genderRowState = cubit.state.genderRowState;
        expect(genderRowState.selectedGender, Gender.female);
        expect(genderRowState.showGenderError, false);
      });

      test("test showGenderError is true when gender is not selected", () {
        cubit.doIntent(RegisterEvents.onGenderSelected(null));
        final genderRowState = cubit.state.genderRowState;
        expect(genderRowState.selectedGender, null);
        expect(genderRowState.showGenderError, true);
      });
    });

    group("registerUser test", () {
      test("emits gender error if gender is not selected", () async {
        cubit.doIntent(RegisterEvents.onGenderSelected(null));
        cubit.state.copyWith(
          genderRowState: cubit.state.genderRowState.copyWith(
            showGenderError: true,
          ),
        );
        cubit.doIntent(RegisterEvents.registerUser());
        expect(cubit.state.genderRowState.showGenderError, true);
      });

      test("emits success state if registration is successful", () async {
        final RegisterUserResponse registerUserResponse = RegisterUserResponse(
          token: "token",
          message: "success",
        );
        provideDummy<Result<RegisterUserResponse>>(
          Success<RegisterUserResponse>(data: registerUserResponse),
        );
        when(registerUserUseCase(any)).thenAnswer(
          (_) async =>
              Success<RegisterUserResponse>(data: registerUserResponse),
        );
        when(
          saveTokenUseCase.call(registerUserResponse.token ?? ""),
        ).thenAnswer((_) async => Future.value());
        final registerStatesStream = cubit.stream
            .map((state) => state.registerState)
            .take(3)
            .toList();
        cubit.doIntent(RegisterEvents.onGenderSelected(Gender.female));
        cubit.doIntent(RegisterEvents.registerUser());
        final registerStates = await registerStatesStream;
        expect(registerStates[0].state, equals(StateType.initial));
        expect(registerStates[1].state, equals(StateType.loading));
        expect(registerStates[2].state, equals(StateType.success));
        expect(registerStates[2].data, equals(registerUserResponse));
        verify(
          saveTokenUseCase.call(registerUserResponse.token ?? ""),
        ).called(1);
      });
      test("emits error state if registration fails", () async {
        final exception = Exception("Registration failed");
        provideDummy<Result<RegisterUserResponse>>(
          Error<RegisterUserResponse>(exception: exception),
        );
        when(registerUserUseCase(any)).thenAnswer(
          (_) async => Error<RegisterUserResponse>(exception: exception),
        );
        final registerStatesStream = cubit.stream
            .map((state) => state.registerState)
            .take(3)
            .toList();
        cubit.doIntent(RegisterEvents.onGenderSelected(Gender.female));
        cubit.doIntent(RegisterEvents.registerUser());
        final registerStates = await registerStatesStream;
        expect(registerStates[0].state, equals(StateType.initial));
        expect(registerStates[1].state, equals(StateType.loading));
        expect(registerStates[2].state, equals(StateType.error));
        expect(registerStates[2].exception, equals(exception));
      });
    });
  });
}
