import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/app_constants.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/count_increment_decrement_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/controllers/product_details_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/widgets/color_picker_widget.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/widgets/product_details_carousel_slider.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/widgets/size_picker_widget.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/review_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/screens/product_reviews_screen.dart';
import 'package:crafty_bay_ecommerce/features/wishlist/ui/controllers/wish_list_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String name = '/products/product-details';

  const ProductDetailsScreen({
    super.key,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Color selectedColor = Colors.black;
  final ProductDetailsController _productDetailsController =
      Get.find<ProductDetailsController>();
  final WishListController _wishlistController = Get.find<WishListController>();
  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
          backgroundColor: Colors.black12,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<ProductDetailsController>(builder: (controller) {
          if (controller.isLoading) return const CenterProgressIndicator();

          if (controller.productModel != null) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // product carousel image
                              ProductDetailsCarouselSlider(
                                images: controller.productModel?.photos ?? [],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildProductTitleSection(textStyle),
                                    _buildRatingReviewSection(context),
                                    const Text(
                                      "Color",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    ColorPickerWidget(
                                      colors: controller.productModel!.colors!
                                          .map((e) => AppConstants.colors[e]!)
                                          .toList(),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Size",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizePickerWidget(
                                      sizes: controller.productModel!.sizes!,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                        controller.productModel?.description ??
                                            "",
                                        style: textStyle.bodyMedium?.copyWith(
                                          color: Colors.grey,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                _buildAddToCardSection(context),
              ],
            );
          }

          return const Center(
            child: Text("Product details not found"),
          );
        }),
      ),
    );
  }

  Widget _buildProductTitleSection(TextTheme textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 250,
          child: Text(
            _productDetailsController.productModel?.title ?? "",
            style: textStyle.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        CountIncrementDecrementWidget(
          onChangeCount: (value) {
            _itemCount = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildRatingReviewSection(BuildContext context) {
    return GetBuilder<ReviewController>(builder: (controller) {
      return Row(
        spacing: 4,
        children: [
          const Icon(Icons.star, color: Colors.amber),
          Text(controller.getAverageRating().toStringAsFixed(1)),
          TextButton(
            onPressed: () => _onTapReviews(
              context,
              _productDetailsController.productModel?.sId ?? "",
            ),
            child: const Text("Reviews"),
          ),
          GetBuilder<WishListController>(builder: (ctr) {
            return InkWell(
              onTap: () => _onClickWishList(),
              child: Visibility(
                visible: !ctr.inProgress,
                replacement: const CenterProgressIndicator(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ctr.isProductInWishlist(
                            _productDetailsController.productModel?.sId ?? "")
                        ? AppColors.themeColor
                        : null,
                    border: Border.all(color: AppColors.themeColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: ctr.isProductInWishlist(
                            _productDetailsController.productModel?.sId ?? "")
                        ? Colors.white.withAlpha(150)
                        : AppColors.themeColor,
                    // color: Colors.white.withAlpha(150),
                    size: 16,
                  ),
                ),
              ),
            );
          }),
        ],
      );
    });
  }

  Widget _buildAddToCardSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColors.themeColor.withAlpha(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text("Price"),
                Text(
                    "\$${(_productDetailsController.productModel?.currentPrice ?? 0.00) * _itemCount}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.themeColor,
                    )),
              ],
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Add to cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapReviews(BuildContext context, String id) async {
    Navigator.pushNamed(
      context,
      ProductReviewsScreen.name,
      arguments: id,
    );
    Get.find<ReviewController>().reset();
    await Get.find<ReviewController>().getProductReviews(id);
  }

  void _onClickWishList() async {
    String productId = _productDetailsController.productModel?.sId ?? "";
    var wishlistItem = _wishlistController.productList
            .firstWhereOrNull((element) => element.product?.sId == productId)
            ?.sId ??
        "";
    // check if product is already in wishlist
    if (_wishlistController.isProductInWishlist(productId)) {
      bool isSuccess =
          await _wishlistController.removeFromWishList(wishlistItem);
      if (isSuccess) {
        _reloadWishList();
        if (mounted) {
          showSnackBarMessage(context, "Product removed from wishlist");
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, "Product failed to remove from wishlist", true);
        }
      }
    } else {
      bool isSuccess = await _wishlistController.addToWishList(productId);
      if (isSuccess) {
        _reloadWishList();
        if (mounted) {
          showSnackBarMessage(context, "Product added to wishlist");
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, "Product failed to add into wishlist", true);
        }
      }
    }
  }

  void _reloadWishList() async {
    _wishlistController.reset();
    await _wishlistController.getWishedProductList();
    setState(() {});
  }
}
