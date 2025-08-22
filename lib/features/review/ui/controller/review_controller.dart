import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/paginate_model.dart';
import 'package:crafty_bay_ecommerce/features/review/data/model/review_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class ReviewController extends GetxController {
  bool _isLoading = false;
  final List<ReviewModel> _reviewList = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<ReviewModel> get reviewList => _reviewList;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductReviews(String productId) async {
    bool isSuccess = false;
    _isLoading = true;
    String requestParams = '?product=$productId';
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.reviewListByProductId + requestParams,
    );
    if (response.isSuccess) {
      PaginateModel<ReviewModel> paginateModel =
          PaginateModel<ReviewModel>.fromJson(
        response.responseData["data"],
        ReviewModel.fromJson,
      );
      _reviewList.addAll(paginateModel.results);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  double getAverageRating() {
    double? totalRating = 0.0;
    if (_reviewList.isNotEmpty) {
      totalRating = _reviewList
          .map((e) => e.rating)
          .reduce((a, b) => a! + b!)
          ?.toDouble();
    }
    return totalRating! / _reviewList.length;
  }
}
