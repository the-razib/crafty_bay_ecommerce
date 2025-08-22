import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/controllers/product_details_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_details_screen.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/review_controller.dart';
import 'package:crafty_bay_ecommerce/features/wishlist/ui/controllers/wish_list_controller.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    this.productModel,
  });

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context, productModel?.sId ?? ""),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: 140,
          child: Column(
            children: [
              // product image
              Container(
                width: 140,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha((0.1 * 255).toInt()),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: productModel?.photos != null
                      ? Image.network(productModel?.photos![0] ?? "",
                          width: 120, height: 100, fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        })
                      : Image.asset(
                          AssetsPath.nikeShoes,
                          width: 120,
                          height: 120,
                        ),
                ),
              ),

              // product details (name, price, rating star, favorite button)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // product name
                    Tooltip(
                      message:
                          productModel?.title ?? "New Year Special Shoe 30",
                      child: Text(
                        productModel?.title ?? "New Year Special Shoe 30",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // price, rating star, favorite button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // price
                        Text(
                          "\$${productModel?.currentPrice}",
                          style: const TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        // rating star
                        const Wrap(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            Text(
                              "4.5",
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),

                        // favorite Button
                        GetBuilder<WishListController>(builder: (controller) {
                          return Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: controller.isProductInWishlist(
                                      productModel?.sId ?? "")
                                  ? AppColors.themeColor
                                  : null,
                              border: Border.all(
                                color: AppColors.themeColor,
                              ),
                              // color: AppColors.themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Icon(
                              Icons.favorite_border_outlined,
                              size: 16,
                              color: controller.isProductInWishlist(
                                      productModel?.sId ?? "")
                                  ? Colors.white
                                  : AppColors.themeColor,
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTap(BuildContext context, String productId) {
    Get.find<ProductDetailsController>().getProductById(productId);
    Get.find<ReviewController>().getProductReviews(productId);

    Navigator.pushNamed(
      context,
      ProductDetailsScreen.name,
    );
  }
}
