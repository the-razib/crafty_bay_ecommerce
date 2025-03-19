import 'package:crafty_bay_ecommerce/features/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/widgets/app_logo_widgets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen()async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, EmailVerificationScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            children: [
              Spacer(),
              AppLogoWidget(),
              Spacer(),
              CircularProgressIndicator(
                color: AppColors.themeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


