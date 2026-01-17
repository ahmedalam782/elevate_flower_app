import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/login/domain/entities/login_response_entity.dart';
import 'package:elevate_flower_app/features/login/domain/entities/user_model_entity.dart';
import 'package:elevate_flower_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late LoginCubit cubit;
  late MockLoginUseCase mockLoginUseCase;

  setUpAll(() {
    provideDummy<Result<LoginResponseEntity>>(
      const Success<LoginResponseEntity>(
        data: LoginResponseEntity(
          message: "Login successful",
          token: "dummy_token",
          user: UserModelEntity(
            id: "dummy_id",
            firstName: "Dummy",
            lastName: "User",
            email: "dummy@test.com",
            phone: "000000",
            photo: "",
            role: "user",
            wishlist: [],
            addresses: [],
            createdAt: "2024-01-01",
          ),
        ),
      ),
    );
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    cubit = LoginCubit(mockLoginUseCase);
  });

  group("LoginCubit Tests", () {
    test("initial state is correct", () {
      expect(cubit.state.loginState.state, StateType.initial);
      expect(cubit.state.isRememberMe, false);
    });

    test("initial controllers are empty", () {
      expect(cubit.emailController.text, isEmpty);
      expect(cubit.passwordController.text, isEmpty);
    });

    group("loginUserEvent", () {
      test("does not login if form is invalid", () async {
        final invalidCubit = LoginCubit(mockLoginUseCase);

        // Act
        invalidCubit.doIntent(LoginEvents.loginUserEvent());
        // Assert
        await Future.delayed(const Duration(milliseconds: 100));

        expect(invalidCubit.state.loginState.state, StateType.initial);

        verifyNever(
          mockLoginUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
            rememberMe: anyNamed('rememberMe'),
          ),
        );

        await invalidCubit.close();
      });

      test("emits loading then success on successful login", () async {
        const response = LoginResponseEntity(
          message: "Login successful",
          token: "token_123",
          user: UserModelEntity(
            id: "1",
            firstName: "John",
            lastName: "Doe",
            email: "test@example.com",
            phone: "123",
            photo: "",
            role: "user",
            wishlist: [],
            addresses: [],
            createdAt: "2024-01-01",
          ),
        );

        when(
          mockLoginUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer(
          (_) async => const Success<LoginResponseEntity>(data: response),
        );

        cubit.emailController.text = "test@example.com";
        cubit.passwordController.text = "password123";
        cubit.toggleRememberMe(true);

        expect(cubit.state.isRememberMe, true);

        final states = cubit.stream
            .map((state) => state.loginState)
            .take(2)
            .toList();

        cubit.doIntent(LoginEvents.loginUserEvent());

        final result = await states;

        expect(result[0].state, StateType.loading);
        expect(result[1].state, StateType.success);
        expect(result[1].data, response);

        verify(
          mockLoginUseCase.call(
            email: "test@example.com",
            password: "password123",
            rememberMe: true,
          ),
        ).called(1);
      });

      test("emits error state when login fails", () async {
        final exception = Exception("Invalid credentials");

        when(
          mockLoginUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer(
          (_) async => Error<LoginResponseEntity>(exception: exception),
        );

        cubit.emailController.text = "test@example.com";
        cubit.passwordController.text = "wrong";
        cubit.toggleRememberMe(false);

        final states = cubit.stream
            .map((state) => state.loginState)
            .take(2)
            .toList();

        cubit.doIntent(LoginEvents.loginUserEvent());

        final result = await states;

        expect(result[0].state, StateType.loading);
        expect(result[1].state, StateType.error);
        expect(result[1].exception, exception);

        verify(
          mockLoginUseCase.call(
            email: "test@example.com",
            password: "wrong",
            rememberMe: false,
          ),
        ).called(1);
      });

      test("trims email but not password", () async {
        when(
          mockLoginUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
            rememberMe: anyNamed('rememberMe'),
          ),
        ).thenAnswer(
          (_) async => const Success<LoginResponseEntity>(
            data: LoginResponseEntity(
              message: "Login successful",
              token: "dummy",
              user: UserModelEntity(
                id: "1",
                firstName: "Test",
                lastName: "User",
                email: "test@test.com",
                phone: "000",
                photo: "",
                role: "user",
                wishlist: [],
                addresses: [],
                createdAt: "2024-01-01",
              ),
            ),
          ),
        );

        cubit.emailController.text = "  test@example.com  ";
        cubit.passwordController.text = "  pass  ";

        cubit.doIntent(LoginEvents.loginUserEvent());

        await Future.delayed(const Duration(milliseconds: 100));

        verify(
          mockLoginUseCase.call(
            email: "test@example.com",
            password: "  pass  ",
            rememberMe: false,
          ),
        ).called(1);
      });
    });

    test("controllers are disposed on close", () async {
      await cubit.close();

      expect(
        () => cubit.emailController.text = "test",
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
