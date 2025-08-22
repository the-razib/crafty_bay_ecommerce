import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class EmailVerificationController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.verifyEmail(email),
    );
    if (response.isSuccess) {
      isSuccess = true;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
