class Urls {
  static const String _baseUrl = "https://ecommerce-api.codesilicon.com/api";

  static String verifyEmail(String email) => "$_baseUrl/UserLogin/$email";
  static String verifyOtp(String email, String otp) =>
      "$_baseUrl/VerifyLogin/$email/$otp";

  static String readProfile = "$_baseUrl/ReadProfile";
  static String bannerListUrl = '$_baseUrl/ListProductSlider';
  static String categoryListUrl = '$_baseUrl/CategoryList';

  static String productListByRemarkUrl(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String productListByCategoryUrl(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String productDetailsUrl(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';

  static String reviewListByProductId(int productId) =>
      '$_baseUrl/ListReviewByProduct/$productId';
}
