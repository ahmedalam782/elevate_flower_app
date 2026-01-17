abstract class LoginLocalDataSourceContract {
  Future<void> saveToken(String token);
  Future<void> saveRememberMe(bool rememberMe);
  Future<void> clearLoginData();
}