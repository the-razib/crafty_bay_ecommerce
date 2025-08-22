import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class ProductDetailsController extends GetxController {
  bool _isLoading = true;
  ProductModel? _productModel;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  ProductModel? get productModel => _productModel;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductById(String productId) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productByIdUrl(productId),
    );
    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.responseData["data"]);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
