import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/product_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/center_progress_indicator.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_item_widget.dart';

class ProductsScreen extends StatefulWidget {
  static const String name = "/products-screen";

  const ProductsScreen({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  final ProductListController _productListController =
      Get.find<ProductListController>();

  @override
  void initState() {
    _loadMoreData();
    super.initState();
  }

  Future<void> _loadMoreData() async {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      await _productListController.getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_productListController.inProgress) {
      return const Scaffold(body: CenterProgressIndicator());
    }

    if (widget.data["isLoading"] == false &&
            widget.data["productList"] == null ||
        widget.data["productList"]?.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Products not found"),
        ),
        body: const Center(
          child: Text(
            "No Products Available",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data["title"] ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GetBuilder<ProductListController>(builder: (controller) {
          return GridView.builder(
            // itemCount: widget.data["productList"]?.length,
            itemCount: controller.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (ctx, index) => FittedBox(
                child: ProductItemWidget(
              productModel: controller.productList[index],
            )),
          );
        }),
      ),
    );
  }
}
