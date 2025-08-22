import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/category_list_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/category_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;
  CategoryListModel? _categoryListModel;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<CategoryModel> get categoryList => _categoryListModel?.data ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.categoryListUrl);
    if (response.isSuccess) {
      _categoryListModel = CategoryListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
