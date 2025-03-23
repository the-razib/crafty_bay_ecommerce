import 'package:crafty_bay_ecommerce/features/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/app_ber_icon_botton.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/product_search_ber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearchBer(
                textEditingController: _searchTEController,
              ),
              const SizedBox(height: 16),
              HomeCarouselSlider()
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetPath.navBerAppLogoSvg),
      actions: [
        AppBerIconButton(
          icon: Icons.person,
          onTab: () {},
        ),
        const SizedBox(width: 6),
        AppBerIconButton(
          icon: Icons.phone,
          onTab: () {},
        ),
        const SizedBox(width: 6),
        AppBerIconButton(
          icon: Icons.notifications_active,
          onTab: () {},
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

