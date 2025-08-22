import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/review/data/model/review_model.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/review_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/screens/create_review_screen.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  static const String name = '/products/reviews';

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Reviews"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildReviewSection(textStyle),
          ),
          _buildAddReviewSection(),
        ],
      ),
    );
  }

  Widget _buildAddReviewSection() {
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
          const Text(
            "Reviews (1000)",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Get.toNamed(CreateReviewScreen.name);
            },
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              elevation: WidgetStateProperty.all(2.0),
              shadowColor: WidgetStateProperty.all(AppColors.themeColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(textStyle) {
    final ReviewController reviewController = Get.find<ReviewController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: reviewController.reviewList?.length ?? 0,
        itemBuilder: (context, index) {
          final ReviewModel reviewModel = reviewController.reviewList![index];
          return Card(
            elevation: 0.05,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.black12,
                        radius: 16,
                        child: Icon(
                          Icons.person_outline,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${reviewModel.user?.firstName ?? ""} ${reviewModel.user?.lastName ?? ""}",
                        style: textStyle.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reviewModel.comment ?? "",
                    style: textStyle.bodySmall.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
