import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:get/get.dart';

class DeleteCartController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteCartItem(int id) async {
    bool isSuccess = false;

    _inBuffer = true;
    _errorMessage = null;
    update();

    NetworkResponse networkResponse =
    await Get.find<NetworkCaller>().getRequest(
      url: Urls.deleteCartListUrl(id),
    );

    if (networkResponse.isSuccess) {
      final data = networkResponse.body?['data'];

      if (data == 1) {
        isSuccess = true;
      } else {
        _errorMessage = 'Cart item could not be deleted';
      }
    } else {
      _errorMessage = networkResponse.errorMessage;
    }

    _inBuffer = false;
    update();

    return isSuccess;
  }
}