import 'package:crafty_bay_ecommerce/freatures/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/freatures/app/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            children: [
              Spacer(),
              SvgPicture.asset(
                AssetPath.appLogoSvg,
                width: 120,
              ),
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
