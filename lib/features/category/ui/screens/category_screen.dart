import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/main_layout_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/category_items_icon_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const String name = "/category";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryListController _categoryListController =
      Get.find<CategoryListController>();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(_loadMoreData);
    super.initState();
  }

  Future<void> _loadMoreData() async {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      await _categoryListController.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        leading: BackButton(
          onPressed: () {
            Get.find<MainLayoutController>().backToHome();
          },
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (_, __) {
          Get.find<MainLayoutController>().backToHome();
        },
        child: GetBuilder<CategoryListController>(builder: (controller) {
          return GridView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            itemCount: controller.categoryList?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) => CategoryItemsIconWidget(
              title: controller.categoryList?[index].title ?? "",
              icon: Icons.image_outlined,
              imageUrl: controller.categoryList?[index].icon,
              // categoryId: controller.categoryList[index].id!,
              categoryId: controller.categoryList?[index].sId ?? "",
            ),
          );
        }),
      ),
    );
  }
}
