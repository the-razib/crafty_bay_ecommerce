import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';

class UserController extends GetxController {
  bool _isLoading = false;
  bool _isUserLoggedIn = false;

  bool get isLoading => _isLoading;
  bool get isUserLoggedIn => _isUserLoggedIn;

  Future<void> checkUserLoggedIn() async {
    _isLoading = true;
    update();
    _isUserLoggedIn = await Get.find<AuthController>().isUserLoggedIn();
    _isLoading = false;
    update();
  }
}
