class EndPoints {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  static const String login = "/auth/signin";
  static const String register = "/auth/signup";
  static const String forgetPasswordEndpoint = "/auth/forgotPassword";
  static const String verifyResetEndpoint = "/auth/verifyResetCode";
  static const String resetPasswordEndpoint = "/auth/resetPassword";
  static const String productsEndpoint = "/products";
  static const String bestSellersEndpoint = "/best-seller";
  static const String allCategories = "/categories";
  static const String allProducts = "/products";
  static const String homeEndpoint = "/home";
  static const String getAllOccasions = "/occasions";
  static const String getAllProducts = "/products";
  static const String logout = "/auth/logout";

  static const String profileData = "/auth/profile-data";

  // CART
  static const String cartEndPoint = "/cart";

  static const String getUserProfile = "/auth/profile-data";
  static const String editUserProfile = "/auth/editProfile";
  static const String updateProfilePhoto = "/auth/upload-photo";
  static const String userAddresses = "/addresses";
}

class Apikeys {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String userId = 'userId';
  static const String rememberMe = 'rememberMe';
  static const String language = 'language';
}

class QueryParameter {
  static const String categoryQuery = 'category';
}
