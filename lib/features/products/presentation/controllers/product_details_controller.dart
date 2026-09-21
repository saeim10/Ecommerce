import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:craftybay_ecommerce/features/products/data/models/product_details_model.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductDetailsModel> _productDetailsList = [];
  List<ProductDetailsModel> get productDetailsList => _productDetailsList;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inBuffer = true;
    update();

    final NetworkResponse networkResponse = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productDetailsByIdUrl(productId));

    if (networkResponse.isSuccess) {
      List<ProductDetailsModel> list = [];
      for(Map<String, dynamic> jsonData in networkResponse.body!['data']){
        list.add(ProductDetailsModel.fromJson(jsonData));
      }
      _productDetailsList = list;
      isSuccess = true;
      _errorMessage = null;
    }else {
      _errorMessage = networkResponse.errorMessage;
    }

    _inBuffer = false;
    update();
    return isSuccess;
  }
}
