import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/assets_path.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/category_model.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/product_model.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/main_layout_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/new_product_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/popular_product_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/regular_product_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/special_product_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/top_product_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/trending_product_list_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/app_bar_icon_button.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/category_items_icon_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/controller/home_carousel_slider_controller.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/home_title_section.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/product_search_bar.dart';
import 'package:crafty_bay_ecommerce/features/home/ui/widgets/shimmer_product_list_view.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/products_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            // spacing: 12,
            children: [
              // ---------- Product Search bar
              const ProductSearchBar(),
              const SizedBox(height: 12),

              // ---------- Home Carousel slider
              GetBuilder<HomeCarouselSliderController>(builder: (controller) {
                if (controller.inProgress) {
                  return SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  );
                }
                return HomeCarouselSlider(
                  sliders: controller.sliders ?? [],
                );
              }),
              const SizedBox(height: 16),

              // ---------- Home Category List
              HomeTitleSection(
                  title: 'All Categories',
                  onPressed: () {
                    Get.find<MainLayoutController>().goToCategoryScreen();
                  }),
              GetBuilder<CategoryListController>(builder: (controller) {
                if (controller.inProgress) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: const SizedBox(
                      width: double.infinity,
                      height: 80.0,
                      child: ColoredBox(color: Colors.red),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 24,
                    children: _getCategoryList(controller.categoryList ?? []),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // ---------- Home Popular Products List
              HomeTitleSection(
                title: "Popular",
                onPressed: () => _goToProductScreen(
                  context: context,
                  screenName: ProductsScreen.name,
                  isLoading: Get.find<PopularProductListController>().isLoading,
                  title: "Popular Products",
                  productList:
                      Get.find<PopularProductListController>().productList,
                ),
              ),
              GetBuilder<PopularProductListController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return const ShimmerProductListView();
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getProductListByRemark(
                        controller.productList,
                        "popular",
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // ---------- Home Spacial Products
              HomeTitleSection(
                title: "Special",
                onPressed: () => _goToProductScreen(
                  context: context,
                  screenName: ProductsScreen.name,
                  isLoading: Get.find<SpecialProductListController>().isLoading,
                  title: "Special Products",
                  productList:
                      Get.find<SpecialProductListController>().productList,
                ),
              ),
              GetBuilder<SpecialProductListController>(builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _getProductListByRemark(
                        controller.productList, "trending"),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // ---------- Home New Products
              HomeTitleSection(
                title: "New",
                onPressed: () => _goToProductScreen(
                  context: context,
                  screenName: ProductsScreen.name,
                  isLoading: Get.find<NewProductListController>().isLoading,
                  title: "New Products",
                  productList: Get.find<NewProductListController>().productList,
                ),
              ),
              GetBuilder<NewProductListController>(builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        _getProductListByRemark(controller.productList, "new"),
                  ),
                );
              }),

              // ---------- Home Top Products
              HomeTitleSection(
                title: "Top",
                onPressed: () => _goToProductScreen(
                  context: context,
                  screenName: ProductsScreen.name,
                  isLoading: Get.find<TopProductListController>().isLoading,
                  title: "Top Products",
                  productList:
                      Get.find<TrendingProductListController>().productList,
                ),
              ),
              GetBuilder<TopProductListController>(builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        _getProductListByRemark(controller.productList, "top"),
                  ),
                );
              }),

              // ---------- Home Trending Products
              HomeTitleSection(
                title: "Trending",
                onPressed: () => _goToProductScreen(
                  context: context,
                  screenName: ProductsScreen.name,
                  isLoading:
                      Get.find<TrendingProductListController>().isLoading,
                  title: "Trending Products",
                  productList:
                      Get.find<TrendingProductListController>().productList,
                ),
              ),
              GetBuilder<TrendingProductListController>(builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _getProductListByRemark(
                        controller.productList, "trending"),
                  ),
                );
              }),

              // ---------- Home Regular Products
              HomeTitleSection(
                title: "Regular",
                onPressed: () => _goToProductScreen(
                  context: context,
                  screenName: ProductsScreen.name,
                  isLoading: Get.find<RegularProductListController>().isLoading,
                  title: "Regular Products",
                  productList:
                      Get.find<RegularProductListController>().productList,
                ),
              ),
              GetBuilder<RegularProductListController>(builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _getProductListByRemark(
                        controller.productList, "regular"),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SizedBox(
        width: 120,
        child: SvgPicture.asset(AssetsPath.logoNav),
      ),
      actions: const [
        AppBarIconButton(
          icon: Icons.person_2_outlined,
        ),
        AppBarIconButton(
          icon: Icons.call_outlined,
        ),
        AppBarIconButton(
          icon: Icons.notifications_outlined,
        ),
      ],
    );
  }

  List<Widget> _getCategoryList(List<CategoryModel> categoryList) {
    List<Widget> list = [];
    for (CategoryModel category in categoryList) {
      list.add(CategoryItemsIconWidget(
        title: category.title ?? "",
        icon: Icons.image_outlined,
        imageUrl: category.icon,
        categoryId: 1,
      ));
    }
    return list;
  }

  void _goToProductScreen({
    required BuildContext context,
    required String screenName,
    required bool isLoading,
    required String title,
    required List<ProductModel> productList,
  }) {
    Navigator.pushNamed(
      context,
      screenName,
      arguments: {
        "isLoading": isLoading,
        "title": title,
        "productList": productList,
      },
    );
  }

  List<Widget> _getProductListByRemark(
    List<ProductModel> productList,
    String remark,
  ) {
    List<Widget> list = [];
    for (ProductModel product in productList) {
      list.add(
        ProductItemWidget(
          productModel: product,
        ),
      );
    }
    return list;
  }
}
