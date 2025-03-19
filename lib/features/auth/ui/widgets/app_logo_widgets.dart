import 'package:crafty_bay_ecommerce/features/app/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPath.appLogoSvg,
      width: 120,
    );
  }
}