import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/snack_bar_message.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/controllers/product_details_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/add_new_review_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/review_controller.dart';
import 'package:crafty_bay_ecommerce/features/review/ui/controller/update_review_controller.dart';

class CreateReviewScreen extends StatefulWidget {
  static const String name = '/products/create-review';

  const CreateReviewScreen({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final ProductDetailsController _productDetailsController =
      Get.find<ProductDetailsController>();
  final ReviewController _reviewController = Get.find<ReviewController>();
  final TextEditingController _reviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double givenRating = 0.0;
  @override
  void initState() {
    // check if id type is int
    givenRating =
        _reviewController.reviewList[widget.data["index"]].rating ?? 0.0;
    _reviewTEController.text =
        _reviewController.reviewList[widget.data["index"]].comment ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Review"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              Text(
                _productDetailsController.productModel!.title ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              RatingBar.builder(
                initialRating: givenRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  givenRating = rating;
                  setState(() {});
                },
              ),
              TextFormField(
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: 'Comment',
                ),
                controller: _reviewTEController,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Please enter your review";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () => _submitReview(),
                child: widget.data["index"] >= 0
                    ? const Text("Update")
                    : const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReview() async {
    if (_formKey.currentState?.validate() ?? false) {
      print("=================> update");
      bool isSuccess = false;
      if (widget.data["index"] >= 0) {
        Map<String, dynamic> requestBody = {
          "comment": _reviewTEController.text,
          "rating": givenRating,
        };
        isSuccess = await Get.find<UpdateReviewController>().updateReviewById(
            requestBody,
            _reviewController.reviewList[widget.data["index"]].sId.toString());
        setState(() {});
      } else {
        Map<String, dynamic> requestBody = {
          "product": _productDetailsController.productModel!.sId.toString(),
          "comment": _reviewTEController.text,
          "rating": givenRating,
        };
        isSuccess =
            await Get.find<AddNewReviewController>().addNewReview(requestBody);
        setState(() {});
      }
      if (isSuccess) {
        Get.find<ReviewController>().reset();
        Get.find<ReviewController>()
            .getProductReviews(widget.data["productId"]);
        Navigator.pop(context);
      } else {
        showSnackBarMessage(context, "Something went wrong", true);
      }
    }
  }
}
