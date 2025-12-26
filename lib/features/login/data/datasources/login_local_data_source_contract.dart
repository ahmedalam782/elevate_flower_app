abstract class LoginLocalDataSourceContract {
  Future<void> saveToken(String token);
  Future<void> saveUserId(String userId);
  Future<void> saveRememberMe(bool rememberMe);
  Future<String?> getToken();
  Future<String?> getUserId();
  Future<bool> getRememberMe();
  Future<void> clearLoginData();
}