import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/login/domain/entities/login_response_entity.dart';
import 'package:elevate_flower_app/features/login/domain/entities/user_model_entity.dart';
import 'package:elevate_flower_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late LoginCubit cubit;
  late MockLoginUseCase mockLoginUseCase;

  // ✅ provideDummy خارج الـ tests عشان يشتغل مع كل التستات
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
    cubit = LoginCubit(mockLoginUseCase, formValidator: () => true);
  });

  group("LoginCubit test", () {
    test("test if initial state is correct", () {
      expect(cubit.state, isA<LoginStates>());
      expect(cubit.state.loginState.state, equals(StateType.initial));
    });

    test("test initial values are correct", () {
      expect(cubit.emailController.text, isEmpty);
      expect(cubit.passwordController.text, isEmpty);
      expect(cubit.isRememberMe, false);
      // ✅ مش محتاجين نتشيك على formKey.currentState لأنه محتاج Widget
    });

    group("loginUserEvent tests", () {
      test("does not emit loading state when form is invalid", () async {
        // Arrange
        final invalidCubit = LoginCubit(
          mockLoginUseCase,
          formValidator: () => false, // ← form مش valid
        );

        invalidCubit.emailController.text = "";
        invalidCubit.passwordController.text = "";

        // Act
        invalidCubit.doIntent(LoginEvents.loginUserEvent());

        // Assert
        await Future.delayed(const Duration(milliseconds: 100));
        expect(invalidCubit.state.loginState.state, equals(StateType.initial));
        verifyNever(
          mockLoginUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
            rememberMe: anyNamed('rememberMe'),
          ),
        );

        await invalidCubit.close();
      });

      test("emits success state when login is successful", () async {
        // Arrange
        const loginResponse = LoginResponseEntity(
          message: "Login successful",
          token: "test_token_123",
          user: UserModelEntity(
            id: "user_123",
            firstName: "John",
            lastName: "Doe",
            email: "test@example.com",
            phone: "123456",
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
          (_) async => const Success<LoginResponseEntity>(data: loginResponse),
        );

        cubit.emailController.text = "test@example.com";
        cubit.passwordController.text = "password123";
        cubit.isRememberMe = true;

        final loginStatesStream = cubit.stream
            .map((state) => state.loginState)
            .take(2)
            .toList();

        // Act
        cubit.doIntent(LoginEvents.loginUserEvent());

        // Assert
        final loginStates = await loginStatesStream;
        expect(loginStates[0].state, equals(StateType.loading));
        expect(loginStates[1].state, equals(StateType.success));
        expect(loginStates[1].data, equals(loginResponse));

        verify(
          mockLoginUseCase.call(
            email: "test@example.com",
            password: "password123",
            rememberMe: true,
          ),
        ).called(1);
      });

      test("emits error state when login fails", () async {
        // Arrange
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
        cubit.passwordController.text = "wrongpassword";
        cubit.isRememberMe = false;

        final loginStatesStream = cubit.stream
            .map((state) => state.loginState)
            .take(2)
            .toList();

        // Act
        cubit.doIntent(LoginEvents.loginUserEvent());

        // Assert
        final loginStates = await loginStatesStream;
        expect(loginStates[0].state, equals(StateType.loading));
        expect(loginStates[1].state, equals(StateType.error));
        expect(loginStates[1].exception, equals(exception));

        verify(
          mockLoginUseCase.call(
            email: "test@example.com",
            password: "wrongpassword",
            rememberMe: false,
          ),
        ).called(1);
      });

      test("trims email before calling use case", () async {
        // Arrange
        const loginResponse = LoginResponseEntity(
          message: "Login successful",
          token: "test_token",
          user: UserModelEntity(
            id: "user_123",
            firstName: "John",
            lastName: "Doe",
            email: "test@example.com",
            phone: "123456",
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
          (_) async => const Success<LoginResponseEntity>(data: loginResponse),
        );

        cubit.emailController.text = "  test@example.com  ";
        cubit.passwordController.text = "password123";

        // Act
        cubit.doIntent(LoginEvents.loginUserEvent());
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        verify(
          mockLoginUseCase.call(
            email: "test@example.com", // Should be trimmed
            password: "password123",
            rememberMe: false,
          ),
        ).called(1);
      });

      test("does not trim password before calling use case", () async {
        // Arrange
        const loginResponse = LoginResponseEntity(
          message: "Login successful",
          token: "test_token",
          user: UserModelEntity(
            id: "user_123",
            firstName: "John",
            lastName: "Doe",
            email: "test@example.com",
            phone: "123456",
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
          (_) async => const Success<LoginResponseEntity>(data: loginResponse),
        );

        cubit.emailController.text = "test@example.com";
        cubit.passwordController.text = "  password123  ";

        // Act
        cubit.doIntent(LoginEvents.loginUserEvent());
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        verify(
          mockLoginUseCase.call(
            email: "test@example.com",
            password: "  password123  ", // Should NOT be trimmed
            rememberMe: false,
          ),
        ).called(1);
      });

      test("uses isRememberMe value correctly", () async {
        // Arrange
        const loginResponse = LoginResponseEntity(
          message: "Login successful",
          token: "test_token",
          user: UserModelEntity(
            id: "user_123",
            firstName: "John",
            lastName: "Doe",
            email: "test@example.com",
            phone: "123456",
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
          (_) async => const Success<LoginResponseEntity>(data: loginResponse),
        );

        cubit.emailController.text = "test@example.com";
        cubit.passwordController.text = "password123";
        cubit.isRememberMe = true;

        // Act
        cubit.doIntent(LoginEvents.loginUserEvent());
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        verify(
          mockLoginUseCase.call(
            email: "test@example.com",
            password: "password123",
            rememberMe: true,
          ),
        ).called(1);
      });
    });

    group("controller cleanup tests", () {
      test("controllers are properly disposed after close", () async {
        // Arrange
        final testCubit = LoginCubit(
          mockLoginUseCase,
          formValidator: () => true,
        );
        testCubit.emailController.text = "test@example.com";

        // Act
        await testCubit.close();

        // Assert - محاولة استخدام disposed controller لازم ترمي error
        expect(
          () => testCubit.emailController.text = "new text",
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });
}