
import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:craftybay_ecommerce/features/category/data/model/list_product_by_category_model.dart';
import 'package:get/get.dart';

class ListProductByCategoryController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  List<ListProductByCategoryModel> _productCategoryList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<ListProductByCategoryModel> get productCategoryList => _productCategoryList;

  Future<bool> getProductByCategory(int categoryId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse networkResponse = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productByCategoryUrl(categoryId),
    );

    if (networkResponse.isSuccess) {
      _errorMessage = null;
      List<ListProductByCategoryModel> list = [];
      for(Map<String, dynamic> jsonData in networkResponse.body!['data']){
        list.add(ListProductByCategoryModel.fromJson(jsonData));
      }
      _productCategoryList = list;
      isSuccess = true;
    }
    _inProgress = false;
     update();
    return isSuccess;
  }
}