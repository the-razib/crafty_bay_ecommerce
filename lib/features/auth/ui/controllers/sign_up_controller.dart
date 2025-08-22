import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class SignUpController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Future<bool> signUp(Map<String, dynamic> body) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.signUp, body);
    if (response.statusCode == 200) {
      isSuccess = true;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
