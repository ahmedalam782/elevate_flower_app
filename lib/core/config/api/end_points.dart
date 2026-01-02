class EndPoints {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  static const String login = "/auth/signin";
  static const String register = "/auth/signup";
  static const String forgetPasswordEndpoint = "/auth/forgotPassword";
  static const String verifyResetEndpoint = "/auth/verifyResetCode";
  static const String resetPasswordEndpoint = "/auth/resetPassword";

  static const String bestSellersEndpoint = "/best-seller";

  static const String allCategories = "/categories";
  static const String allProducts = "/products";
  static const String homeEndpoint = "/home";

}

class Apikeys {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String userId = 'userId';
  static const String rememberMe = 'rememberMe';
}

class QueryParameter {
  static const String categoryQuery = 'category';
}
