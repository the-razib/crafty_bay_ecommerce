import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/auth/data/models/sign_in_model.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class SignInController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.signIn, body);
    if (response.isSuccess) {
      SignInModel signInModel = SignInModel.fromJson(response.responseData);
      await Get.find<AuthController>()
          .saveUserData(signInModel.data!.token!, signInModel.data!.user!);
      isSuccess = true;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
