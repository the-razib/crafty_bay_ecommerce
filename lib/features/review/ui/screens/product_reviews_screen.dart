import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/user_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/data/model/review_model.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/delete_review_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/review_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/screens/create_review_screen.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key, required this.productId});
  static const String name = '/products/reviews';

  final String productId;

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  final ReviewController _reviewController = Get.find<ReviewController>();

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
          Visibility(
            visible: _reviewController.lastPage == null,
            replacement: TextButton(
                onPressed: () async {
                  await _reviewController.getProductReviews(widget.productId);
                  setState(() {});
                },
                child: const Text("Load more")),
            child: const SizedBox(),
          ),
          GetBuilder<ReviewController>(builder: (controller) {
            return Visibility(
              visible: !controller.isLoading,
              replacement: const LinearProgressIndicator(),
              child: _buildAddReviewSection(context),
            );
          })
        ],
      ),
    );
  }

  Widget _buildReviewSection(textStyle) {
    final ReviewController reviewController = Get.find<ReviewController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<ReviewController>(builder: (controller) {
        if (controller.reviewList.isEmpty) {
          return const Center(
            child: Text("No reviews yet"),
          );
        }
        return ListView.builder(
          itemCount: controller.reviewList.length,
          itemBuilder: (context, index) {
            final ReviewModel reviewModel = reviewController.reviewList[index];
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
                        const Spacer(),
                        RatingBar.builder(
                          initialRating: reviewModel.rating ?? 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 16,
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            reviewModel.comment ?? "",
                            style: textStyle.bodySmall.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        if (Get.find<UserController>().isUserLoggedIn &&
                            reviewModel.user?.sId ==
                                Get.find<AuthController>().userModel?.sId)
                          Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    CreateReviewScreen.name,
                                    arguments: {
                                      "productId": widget.productId,
                                      "index": index,
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.themeColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _deleteReview(reviewModel.sId),
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildAddReviewSection(BuildContext context) {
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
          GetBuilder<ReviewController>(builder: (controller) {
            return Text(
              "Reviews (${controller.reviewList.length})",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            );
          }),
          const Spacer(),
          IconButton(
            onPressed: () async {
              if (await Get.find<AuthController>().isUserLoggedIn()) {
                Navigator.pushNamed(context, CreateReviewScreen.name,
                    arguments: {"productId": widget.productId, "index": -1});
              } else {
                Navigator.pushNamed(context, SignInScreen.name);
              }
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

  void _deleteReview(reviewId) async {
    bool isDeleted = await Get.find<DeleteReviewController>().deleteReviewById(
      reviewId ?? "",
    );
    if (isDeleted) {
      _reviewController.reset();
      await _reviewController.getProductReviews(widget.productId);
    } else {
      Get.snackbar("Error", "Failed to delete review");
    }
  }
}
