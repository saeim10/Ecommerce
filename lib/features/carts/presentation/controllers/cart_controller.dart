import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:craftybay_ecommerce/features/carts/data/models/cart_list_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CartListModel> _cartList = [];
  List<CartListModel> get cartList => _cartList;

  Future<bool> getCartList() async {
    bool isSuccess = false;

    _inBuffer = true;
    _errorMessage = null;
    update();

    NetworkResponse networkResponse =
    await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartListUrl,
    );

    if (networkResponse.isSuccess) {
      _cartList = [];

      for (Map<String, dynamic> jsonData
      in networkResponse.body!['data']) {
        _cartList.add(
          CartListModel.fromJson(jsonData),
        );
      }

      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMessage;
    }

    _inBuffer = false;
    update();

    return isSuccess;
  }
}