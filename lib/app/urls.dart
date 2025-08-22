class Urls {
  static const String _baseUrl = "https://ecom-rs8e.onrender.com/api";

  static const String signUp = "$_baseUrl/auth/signup";
  static const String signIn = "$_baseUrl/auth/login";
  static const String verifyOtp = "$_baseUrl/auth/verify-otp";

  static const String readProfile = "$_baseUrl/ReadProfile";
  static const String slides = '$_baseUrl/slides';
  static const String categoryListUrl = '$_baseUrl/categories';

  static String productListByProductSlugUrl(String productSlug) =>
      '$_baseUrl/products/$productSlug';

  static String productListByCategoryUrl(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static const String productListUrl = '$_baseUrl/products';

  static String productByIdUrl(String productId) =>
      '$_baseUrl/products/id/$productId';

  static const String reviewListByProductId = '$_baseUrl/reviews';
  static const String createReview = '$_baseUrl/review';

  static String updateReviewById(String reviewId) =>
      '$_baseUrl/reviews/$reviewId';
  static String deleteReviewById(String reviewId) =>
      '$_baseUrl/reviews/$reviewId';

  static const String wishlist = '$_baseUrl/wishlist';
  static const String cartUrl = '$_baseUrl/cart';
}
