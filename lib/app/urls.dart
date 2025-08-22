class Urls {
  static const String _baseUrl = "https://ecom-rs8e.onrender.com/api";

  static String signIn = "$_baseUrl/auth/login";
  static String signUp = "$_baseUrl/auth/signup";
  static String verifyOtp = "$_baseUrl/auth/verify-otp";

  static String readProfile = "$_baseUrl/ReadProfile";
  static String slides = '$_baseUrl/slides';
  static String categoryListUrl = '$_baseUrl/categories';

  static String productListByProductSlugUrl(String productSlug) =>
      '$_baseUrl/products/$productSlug';

  static String productListByCategoryUrl(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String productListUrl = '$_baseUrl/products';

  static String productByIdUrl(String productId) =>
      '$_baseUrl/products/id/$productId';

  static String reviewListByProductId = '$_baseUrl/reviews';
}
