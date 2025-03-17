import 'package:crafty_bay_ecommerce/freatures/app/app_theme_data.dart';
import 'package:crafty_bay_ecommerce/freatures/auth/ui/screens/splash_screen.dart';
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
      },
    );
  }
}
