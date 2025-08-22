import 'package:flutter/material.dart';
import 'package:crafty_bay_ecommerce/app/app_theme_data.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/splash_screens.dart';

class CraftyBayEcommerceApp extends StatelessWidget {
  const CraftyBayEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => const SplashScreens(),
        EmailVerificationScreen.name: (BuildContext context) =>
            const EmailVerificationScreen(),
        OtpVerificationScreen.name: (BuildContext context) =>
            const OtpVerificationScreen(),
        CompleteProfileScreen.name: (BuildContext context) =>
            const CompleteProfileScreen(),
      },
    );
  }
}
