import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class UpdateReviewController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> updateReviewById(
      Map<String, dynamic> requestBody, String reviewId) async {
    bool isSuccess = false;
    _isLoading = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().patchRequest(
      Urls.updateReviewById(reviewId),
      requestBody,
    );
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
