import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/paginate_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class ProductListByCategoryController extends GetxController {
  bool _isLoading = false;
  final List<ProductModel> _productList = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<ProductModel> get productList => _productList;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductListByCategory(String categoryId) async {
    bool isSuccess = false;
    _isLoading = true;
    String requestParams = "?category=$categoryId";
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productListUrl + requestParams,
    );
    if (response.isSuccess) {
      PaginateModel<ProductModel> paginateModel =
          PaginateModel<ProductModel>.fromJson(
        response.responseData["data"],
        ProductModel.fromJson,
      );
      _productList.addAll(paginateModel.results);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
