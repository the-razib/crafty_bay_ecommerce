import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/review/data/model/review_list_model.dart';
import 'package:crafty_bay_ecommerce/features/review/data/model/review_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class ReviewController extends GetxController {
  bool _isLoading = true;
  ReviewListModel? _reviewListModel;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<ReviewModel>? get reviewList => _reviewListModel?.reviewList ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.reviewListByProductId(productId),
    );
    if (response.isSuccess) {
      _reviewListModel = ReviewListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
