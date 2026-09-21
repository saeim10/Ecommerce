class Urls{
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';
  static const String productSliderUrl = '$_baseUrl/ListProductSlider';
  static const String categoryListUrl = '$_baseUrl/CategoryList';
  static String productByCategoryUrl(int categoryId) {
    return '$_baseUrl/ListProductByCategory/$categoryId';
  }
  static String listProductByRemarkUrl(String remark) {
    return '$_baseUrl/ListProductByRemark/$remark';
  }
  static String productDetailsByIdUrl(int productId) {
    return '$_baseUrl/ProductDetailsById/$productId';
  }

  static String signInUrl(String email){
    return '$_baseUrl/UserLogin/$email';
  }

  static String verifySignInUrl(String email, String otp){
    return '$_baseUrl/VerifyLogin/$email/$otp';
  }

  static const String cartListUrl = '$_baseUrl/CartList';
  static const String createCartUrl = '$_baseUrl/CreateCartList';
  static String deleteCartListUrl(int id) {
    return '$_baseUrl/DeleteCartList/$id';
  }


}