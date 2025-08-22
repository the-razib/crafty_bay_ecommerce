import 'package:get/get.dart';
import 'package:crafty_bay_ecommerce/app/urls.dart';
import 'package:crafty_bay_ecommerce/features/home/data/models/paginate_model.dart';
import 'package:crafty_bay_ecommerce/features/home/data/models/slider_model.dart';
import 'package:crafty_bay_ecommerce/service/network/network_caller.dart';
import 'package:crafty_bay_ecommerce/service/network/network_response.dart';

class HomeCarouselSliderController extends GetxController {
  bool _inProgress = false;
  PaginateModel? _paginateModel;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<SliderModel>? get sliders => _paginateModel?.results ?? [];
  String? get errorMessage => _errorMessage;

  Future<bool> getHomeBannerList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.slides,
    );
    if (response.isSuccess) {
      _errorMessage = null;
      _paginateModel = PaginateModel.fromJson(response.responseData["data"]);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
