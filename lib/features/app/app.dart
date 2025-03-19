import 'package:crafty_bay_ecommerce/features/app/app_theme_data.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context)=> SplashScreen(),
        EmailVerificationScreen.name : (context)=> EmailVerificationScreen(),
        OTPVerificationScreen.name : (context)=> OTPVerificationScreen(),
      },
    );
  }
}
