class Urls {
  // static const String _baseUrl = "https://ecommerce-api.codesilicon.com/api";
  static const String _baseUrl = "https://ecom-rs8e.onrender.com/api";

  static String signIn = "$_baseUrl/auth/login";
  static String signUp = "$_baseUrl/auth/signup";
  static String verifyOtp = "$_baseUrl/auth/verify-otp";

  static String readProfile = "$_baseUrl/ReadProfile";
  static String slides = '$_baseUrl/slides';
  static String categoryListUrl = '$_baseUrl/categories';

  static String productListByRemarkUrl(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String productListByCategoryUrl(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String productDetailsUrl(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';

  static String reviewListByProductId(int productId) =>
      '$_baseUrl/ListReviewByProduct/$productId';
}
