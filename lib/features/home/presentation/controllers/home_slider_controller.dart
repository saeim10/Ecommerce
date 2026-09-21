
import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:craftybay_ecommerce/features/home/data/models/home_slider_model.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<HomeSliderModel> _listSlider = [];
  List<HomeSliderModel> get listSlider => _listSlider;




  Future<bool> getHomeSlider() async {
    bool isSuccess = false;
    _inBuffer = true;
    update();
    NetworkResponse networkResponse = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productSliderUrl);
    if (networkResponse.isSuccess) {
      _errorMessage = null;
      List<HomeSliderModel> list = [];
      for (Map<String, dynamic> jsonData in networkResponse.body!['data']) {
        list.add(HomeSliderModel.fromJson(jsonData));
      }
      _listSlider = list;
      isSuccess = true;
    }
    _inBuffer = false;
    update();
    return isSuccess;
  }
}
