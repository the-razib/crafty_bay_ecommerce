import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/cart/data/model/cart_model.dart';
import 'package:crafty_bay_ecommerce/features/cart/ui/controllers/cart_controller.dart';
import 'package:crafty_bay_ecommerce/features/cart/ui/controllers/delete_cart_item_controller.dart';
import 'package:crafty_bay_ecommerce/features/cart/ui/controllers/update_cart_item_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/count_increment_decrement_widget.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/screens/create_review_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String name = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.find<CartController>();
  final DeleteCartItemController _deleteCartItemController =
      Get.find<DeleteCartItemController>();
  final UpdateCartItemController _updateCartItemController =
      Get.find<UpdateCartItemController>();

  @override
  void initState() {
    _loadCart();
    super.initState();
  }

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

  Widget _buildItemsSection(textStyle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<CartController>(builder: (controller) {
        if (controller.isLoadingGetList) {
          return const CenterProgressIndicator();
        }

        if (controller.cartList.isEmpty) {
          return const Center(
            child: Text("Cart is empty"),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.cartList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.05,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.network(
                      controller.cartList[index].product!.photos![0],
                      width: 80,
                      height: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AssetsPath.nikeShoes,
                          width: 80,
                          height: 80,
                        );
                      },
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
                                controller.cartList[index].product?.title ?? "",
                                style: textStyle.titleSmall.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (controller.cartList[index].color != null ||
                                  controller.cartList[index].size != null)
                                Text(
                                    "${controller.cartList[index].color != null ? "Color: ${controller.cartList[index].color}," : ""}${controller.cartList[index].size != null ? " Size: ${controller.cartList[index].size}" : ""}",
                                    style: textStyle.bodySmall),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "\$${(controller.cartList[index].product!.currentPrice! * controller.cartList[index].quantity!).toStringAsFixed(2)}",
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
                          onPressed: () =>
                              _onClickDelete(controller.cartList[index]),
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: CountIncrementDecrementWidget(
                            count: controller.cartList[index].quantity ?? 1,
                            onChangeCount: (count) => _onClickPlusMinus(
                                controller.cartList[index], count, index),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Price",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
              GetBuilder<CartController>(builder: (controller) {
                return Text(
                  "\$${controller.totalPrice}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.themeColor,
                  ),
                );
              }),
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

  void _onClickDelete(CartModel cartModel) async {
    bool isDeleted =
        await _deleteCartItemController.deleteFromCart(cartModel.sId ?? "");
    if (isDeleted) {
      _loadCart();
    } else {
      Get.snackbar("Error", "Failed to delete cart item");
    }
  }

  void _onClickPlusMinus(CartModel cartModel, int count, int index) async {
    bool isUpdated = await _updateCartItemController.updateCartItem(
        cartModel.sId ?? "", count);
    if (isUpdated) {
      _cartController.cartList[index].quantity = count;
      _cartController.calculateTotalPrice();
      setState(() {});
    } else {
      Get.snackbar("Error", "Failed to update cart item");
    }
  }

  void _loadCart() async {
    _cartController.clearCartList();
    await _cartController.getCartList();
  }
}
