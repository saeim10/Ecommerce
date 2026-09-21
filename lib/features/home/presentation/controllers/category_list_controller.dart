import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:craftybay_ecommerce/features/home/data/models/category_list_model.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CategoryListModel> _categoryList = [];
  List<CategoryListModel> get categoryList => _categoryList;


  Future<bool> categories() async {
    bool isSuccess = false;
    _inBuffer = true;
    update();
    NetworkResponse networkResponse = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.categoryListUrl);
    if(networkResponse.isSuccess){
      _errorMessage = null;
      List<CategoryListModel> list = [];
      for (Map<String, dynamic> jsonData in networkResponse.body!['data']) {
        list.add(CategoryListModel.fromJson(jsonData));
      }
      _categoryList = list;
      isSuccess = true;

    }
   _inBuffer = false;
    update();
    return isSuccess;
  }
}
