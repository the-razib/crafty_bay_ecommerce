import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_list_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class RegularProductListController extends GetxController {
  bool _isLoading = false;
  ProductListModel? _productListModel;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<ProductModel> get productList => _productListModel?.productList ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getNewProductList() async {
    bool isSuccess = false;
    _isLoading = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productListByRemarkUrl("regular"),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      _productListModel = ProductListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage ?? "Something went wrong";
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
