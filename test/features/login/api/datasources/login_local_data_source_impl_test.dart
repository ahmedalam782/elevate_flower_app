import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/login/api/datasources/login_local_data_source_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_local_data_source_impl_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage, SharedPreferences])
void main() {
  late LoginLocalDataSourceImpl dataSourceImpl;
  late MockFlutterSecureStorage secureStorageMock;
  late MockSharedPreferences sharedPreferencesMock;

  setUp(() {
    secureStorageMock = MockFlutterSecureStorage();
    sharedPreferencesMock = MockSharedPreferences();
    dataSourceImpl = LoginLocalDataSourceImpl(
      secureStorage: secureStorageMock,
      sharedPreferences: sharedPreferencesMock,
    );
  });

  group("test login local data source implementation", () {
    test("saveToken saves token in secure storage", () async {
      // Arrange
      const token = "test_token_123";
      when(
        secureStorageMock.write(key: anyNamed("key"), value: anyNamed("value")),
      ).thenAnswer((_) => Future.value());

      // Act
      await dataSourceImpl.saveToken(token);

      // Assert
      verify(
        secureStorageMock.write(key: Apikeys.accessToken, value: token),
      ).called(1);
    });

    test("saveRememberMe saves rememberMe flag in shared preferences", () async {
      // Arrange
      const rememberMe = true;
      when(
        sharedPreferencesMock.setBool(any, any),
      ).thenAnswer((_) => Future.value(true));

      // Act
      await dataSourceImpl.saveRememberMe(rememberMe);

      // Assert
      verify(
        sharedPreferencesMock.setBool(Apikeys.rememberMe, rememberMe),
      ).called(1);
    });

    test("saveRememberMe with false value", () async {
      // Arrange
      const rememberMe = false;
      when(
        sharedPreferencesMock.setBool(any, any),
      ).thenAnswer((_) => Future.value(true));

      // Act
      await dataSourceImpl.saveRememberMe(rememberMe);

      // Assert
      verify(
        sharedPreferencesMock.setBool(Apikeys.rememberMe, rememberMe),
      ).called(1);
    });

    test("clearLoginData deletes token and rememberMe", () async {
      // Arrange
      when(
        secureStorageMock.delete(key: anyNamed("key")),
      ).thenAnswer((_) => Future.value());
      
      when(
        sharedPreferencesMock.remove(any),
      ).thenAnswer((_) => Future.value(true));

      // Act
      await dataSourceImpl.clearLoginData();

      // Assert
      verify(secureStorageMock.delete(key: Apikeys.accessToken)).called(1);
      verify(sharedPreferencesMock.remove(Apikeys.rememberMe)).called(1);
    });
  });
}