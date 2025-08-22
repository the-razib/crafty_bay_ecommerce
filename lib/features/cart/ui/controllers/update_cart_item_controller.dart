import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class UpdateCartItemController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> updateCartItem(String cartId, int quantity) async {
    bool isSuccess = false;
    _isLoading = true;
    update();

    Map<String, dynamic> requestBody = {"quantity": quantity};
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .patchRequest("${Urls.cartUrl}/$cartId", requestBody);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
