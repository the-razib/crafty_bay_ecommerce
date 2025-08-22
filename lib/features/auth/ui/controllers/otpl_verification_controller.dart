import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/controllers/read_profile_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class OtpVerificationController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;
  bool _shouldNavigateCompleteProfile = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;
  bool get shouldNavigateToCompleteProfile => _shouldNavigateCompleteProfile;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.verifyOtp(email, otp),
    );
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      _token = response.responseData["data"];
      // read profile data
      await Get.find<ReadProfileController>().readProfileData(_token!);
      if (Get.find<ReadProfileController>().profileModel == null) {
        _shouldNavigateCompleteProfile = true;
      } else {
        // save access token and profile data
        await Get.find<AuthController>().saveUserData(
            token!, Get.find<ReadProfileController>().profileModel!);
        _shouldNavigateCompleteProfile = false;
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
