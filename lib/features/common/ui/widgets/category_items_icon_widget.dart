import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/controllers/product_list_by_category_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/products_screen.dart';

class CategoryItemsIconWidget extends StatelessWidget {
  const CategoryItemsIconWidget({
    super.key,
    required this.title,
    required this.icon,
    this.imageUrl,
    required this.categoryId,
  });

  final String categoryId;
  final String title;
  final IconData icon;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final ProductListByCategoryController productListByCategoryController =
        Get.find<ProductListByCategoryController>();
    return GestureDetector(
      onTap: () async {
        await productListByCategoryController
            .getProductListByCategory(categoryId);
        await Get.toNamed(
          ProductsScreen.name,
          arguments: {
            "isLoading": ProductListByCategoryController().isLoading,
            "title": title,
            "productList": productListByCategoryController.productList,
          },
        );
      },
      child: Column(
        spacing: 4,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: imageUrl != null
                  ? Image.network(imageUrl!)
                  : Icon(
                      icon,
                      size: 40,
                      color: AppColors.themeColor,
                    ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.themeColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
