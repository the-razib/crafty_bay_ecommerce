import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/auth/data/models/sign_in_model.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class OtpVerificationController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "otp": otp,
    };
    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      Urls.verifyOtp,
      requestBody,
    );
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      SignInModel signInModel =
          SignInModel.fromJson(response.responseData["data"]);
      // read profile data
      await Get.find<AuthController>().saveUserData(
        signInModel.token!,
        signInModel.user!,
      );
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
