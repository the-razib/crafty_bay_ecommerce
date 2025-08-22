import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/paginate_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class ProductListController extends GetxController {
  bool _inProgress = false;
  final List<ProductModel> _productList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<ProductModel> get productList => _productList;
  String? get errorMessage => _errorMessage;
  int count = 0;
  int page = 1;
  int? lastPage = 1;

  Future<bool> getProducts() async {
    if (lastPage == null || page > lastPage!) return false;
    bool isSuccess = false;
    _inProgress = true;
    count = 30;
    update();
    String requestParams = "?count=$count&page=$page";
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.productListUrl + requestParams);
    if (response.isSuccess) {
      PaginateModel<ProductModel> paginateModel =
          PaginateModel<ProductModel>.fromJson(
        response.responseData["data"],
        ProductModel.fromJson,
      );
      _productList.addAll(paginateModel.results);
      lastPage = paginateModel.lastPage;
      page++;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getProductListByCategory(int categoryId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.productListByCategoryUrl(categoryId));
    if (response.isSuccess) {
      // _productListModel = ProductListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
