import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/cart/data/model/cart_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/paginate_model.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class CartController extends GetxController {
  bool _isLoadingAddToCart = false;
  bool get isLoadingAddToCart => _isLoadingAddToCart;
  double _totalPrice = 0.0;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  double get totalPrice => _totalPrice;

  Future<bool> addToCart(String productId) async {
    bool isSuccess = false;
    _isLoadingAddToCart = true;
    update();
    Map<String, dynamic> requestBody = {"product": productId};
    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.cartUrl, requestBody);

    if (response.isSuccess) {
      calculateTotalPrice();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoadingAddToCart = false;
    update();
    return isSuccess;
  }

  bool _isLoadingGetList = false;
  final List<CartModel> _cartList = <CartModel>[];

  bool get isLoadingGetList => _isLoadingGetList;
  List<CartModel> get cartList => _cartList;
  int count = 20;
  int page = 1;
  int? lastPage = 1;

  Future<bool> getCartList() async {
    if (lastPage == null || page > lastPage!) return false;
    bool isSuccess = false;
    _isLoadingGetList = true;
    update();
    String? token = Get.find<AuthController>().accessToken;

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.cartUrl, accessToken: token);
    if (response.isSuccess) {
      final PaginateModel<CartModel> paginateModel =
          PaginateModel<CartModel>.fromJson(
        response.responseData["data"],
        CartModel.fromJson,
      );
      _cartList.addAll(paginateModel.results);
      lastPage = paginateModel.lastPage;
      page++;
      isSuccess = true;
      calculateTotalPrice();
      update();
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoadingGetList = false;
    update();
    return isSuccess;
  }

  void calculateTotalPrice() {
    _totalPrice = 0.0;
    for (var cart in _cartList) {
      double productPrice =
          cart.quantity! * cart.product!.currentPrice!.toDouble();
      _totalPrice += productPrice;
    }
    update();
  }

  void clearCartList() {
    _cartList.clear();
    page = 1;
    lastPage = 1;
    update();
  }
}
