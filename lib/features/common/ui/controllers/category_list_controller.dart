import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/category_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/paginate_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;
  final List<CategoryModel> _categoryList = [];
  String? _errorMessage;
  int count = 0;
  int page = 1;
  int? lastPage = 1;

  bool get inProgress => _inProgress;
  List<CategoryModel>? get categoryList => _categoryList;
  String? get errorMessage => _errorMessage;

  Future<bool> getCategoryList() async {
    if (lastPage == null || page > lastPage!) return false;
    bool isSuccess = false;
    _inProgress = true;
    count = 30;
    update();
    String requestParams = "?count=$count&page=$page";
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest("${Urls.categoryListUrl}$requestParams");
    if (response.isSuccess) {
      PaginateModel<CategoryModel> paginateModel =
          PaginateModel<CategoryModel>.fromJson(
        response.responseData["data"],
        CategoryModel.fromJson,
      );
      _categoryList.addAll(paginateModel.results.map((e) => e));
      // if (paginateModel.lastPage != null && paginateModel.lastPage! > page) {
      lastPage = paginateModel.lastPage;
      page++;
      // }
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
