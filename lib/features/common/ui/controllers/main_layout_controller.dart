import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';

class MainLayoutController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (index == 2 || index == 3) {
      _navigateToSignInScreen(index);
    } else {
      _currentIndex = index;
      update();
    }
  }

  Future<void> _navigateToSignInScreen(int index) async {
    AuthController authController = Get.find<AuthController>();
    if (await authController.isUserLoggedIn()) {
      _currentIndex = index;
      update();
    } else {
      Get.toNamed(SignInScreen.name);
    }
  }

  void goToCategoryScreen() {
    _currentIndex = 1;
    update();
  }

  void backToHome() {
    _currentIndex = 0;
    update();
  }
}
