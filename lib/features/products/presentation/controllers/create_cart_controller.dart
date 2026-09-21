import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:get/get.dart';

class CreateCartController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> createCart({
    required int productId,
    required String color,
    required String size,
    required int qty,
    required int price,
  }) async {
    bool isSuccess = false;

    _inBuffer = true;
    _errorMessage = null;
    update();

    NetworkResponse networkResponse =
    await Get.find<NetworkCaller>().postRequest(
      url: Urls.createCartUrl,
      body: {
        'product_id': productId,
        'color': color,
        'size': size,
        'qty': qty,
        'price': price,
      },
    );

    if (networkResponse.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMessage;
    }

    _inBuffer = false;
    update();

    return isSuccess;
  }
}