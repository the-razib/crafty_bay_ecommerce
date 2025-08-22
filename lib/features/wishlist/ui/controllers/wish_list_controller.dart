import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/common/data/models/paginate_model.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/controllers/auth_controller.dart';
import 'package:crafty_bay_ecommerce/features/wishlist/data/model/wishlist_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  final List<WishlistModel> _productList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<WishlistModel> get productList => _productList;
  String? get errorMessage => _errorMessage;
  int count = 0;
  int page = 1;
  int? lastPage = 1;

  Future<bool> getWishedProductList() async {
    if (lastPage == null || page > lastPage!) return false;
    bool isSuccess = false;
    _inProgress = true;
    count = 30;
    update();
    String requestParams = "?count=$count&page=$page";
    String? accessToken = Get.find<AuthController>().accessToken;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.wishlist + requestParams, accessToken: accessToken);
    if (response.isSuccess) {
      PaginateModel<WishlistModel> paginateModel =
          PaginateModel<WishlistModel>.fromJson(
        response.responseData["data"],
        WishlistModel.fromJson,
      );
      _productList.addAll(paginateModel.results);
      lastPage = paginateModel.lastPage;
      page++;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> addToWishList(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      Urls.wishlist,
      {"product": productId},
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> removeFromWishList(String wishListId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().deleteRequest(
      "${Urls.wishlist}/$wishListId",
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  // Check if product is in wishlist
  bool isProductInWishlist(String productId) {
    return _productList.any((product) => product.product?.sId == productId);
  }

  void reset() {
    _productList.clear();
    _errorMessage = null;
    page = 1;
    lastPage = 1;
  }
}
