import 'package:crafty_bay_ecommerce/features/app/app_theme_data.dart';
import 'package:crafty_bay_ecommerce/features/app/controller_binders.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/compelete_profile_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinders(),
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context)=> SplashScreen(),
        EmailVerificationScreen.name : (context)=> EmailVerificationScreen(),
        OTPVerificationScreen.name : (context)=> OTPVerificationScreen(),
        CompleteProfileScreen.name : (context)=> CompleteProfileScreen(),
        MainBottomNavScreen.name : (context)=> MainBottomNavScreen(),
      },
    );
  }
}
