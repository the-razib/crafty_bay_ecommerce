import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/count_increment_decrement_widget.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/screens/create_review_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const String name = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Cart"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildItemsSection(textStyle),
          ),
          _buildCheckOutSection(),
        ],
      ),
    );
  }

  Widget _buildCheckOutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withAlpha(50),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
              Text(
                "\$100,000.00",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(CreateReviewScreen.name);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                elevation: WidgetStateProperty.all(2.0),
                shadowColor: WidgetStateProperty.all(AppColors.themeColor),
              ),
              child: const Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(textStyle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0.05,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    AssetsPath.nikeShoes,
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Happy New Year Special Deal Save 30%",
                              style: textStyle.titleSmall.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text("Color: Red, Size: X",
                                style: textStyle.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "\$100",
                          style: textStyle.titleSmall.copyWith(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline),
                        color: Colors.grey,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: CountIncrementDecrementWidget(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
