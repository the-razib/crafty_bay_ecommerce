import 'package:crafty_bay_ecommerce/freatures/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData get lightThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.themeColor),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.themeColor),
      brightness: Brightness.dark,
    );
  }
}
