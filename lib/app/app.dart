import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_theme_data.dart';
import 'package:crafty_bay_ecommerce/app/controller_binder.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/resend_otp_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/splash_screens.dart';
import 'package:crafty_bay_ecommerce/features/cart/ui/screens/cart_screen.dart';
import 'package:crafty_bay_ecommerce/features/category/ui/screens/category_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_layout.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_details_screen.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/products_screen.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/screens/create_review_screen.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/screens/product_reviews_screen.dart';

class MCommerceApp extends StatelessWidget {
  const MCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      initialRoute: "/",
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      // routes: {
      //   "/": (ctx) => const SplashScreens(),
      //   MainLayout.name: (ctx) => const MainLayout(),
      //   EmailVerificationScreen.name: (ctx) => const EmailVerificationScreen(),
      //   OtpVerificationScreen.name: (ctx) => const OtpVerificationScreen(),
      //   CompleteProfileScreen.name: (ctx) => const CompleteProfileScreen(),
      //   CategoryScreen.name: (ctx) => const CategoryScreen(),
      // },
      onGenerateRoute: (settings) {
        late Widget widget;
        if (settings.name == SplashScreens.name) {
          widget = const SplashScreens();
        } else if (settings.name == MainLayout.name) {
          widget = const MainLayout();
        } else if (settings.name == SignInScreen.name) {
          widget = const SignInScreen();
        } else if (settings.name == ResendOtpScreen.name) {
          widget = const ResendOtpScreen();
        } else if (settings.name == OtpVerificationScreen.name) {
          final String email = settings.arguments as String;
          widget = OtpVerificationScreen(email: email);
        } else if (settings.name == SignUpScreen.name) {
          widget = const SignUpScreen();
        } else if (settings.name == CategoryScreen.name) {
          widget = const CategoryScreen();
        } else if (settings.name == ProductsScreen.name) {
          Map<String, dynamic> data =
              settings.arguments as Map<String, dynamic>;
          widget = ProductsScreen(data: data);
        } else if (settings.name == ProductDetailsScreen.name) {
          // final int productId = settings.arguments as int;
          widget = const ProductDetailsScreen(
              // productId: productId,
              );
        } else if (settings.name == ProductReviewsScreen.name) {
          final String productId = settings.arguments as String;
          widget = ProductReviewsScreen(productId: productId);
        } else if (settings.name == CreateReviewScreen.name) {
          final Map<String, dynamic> data =
              settings.arguments as Map<String, dynamic>;
          widget = CreateReviewScreen(data: data);
        } else if (settings.name == CartScreen.name) {
          widget = const CartScreen();
        }

        return MaterialPageRoute(builder: (context) {
          return widget;
        });
      },
    );
  }
}
