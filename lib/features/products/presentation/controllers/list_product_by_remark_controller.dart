import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:craftybay_ecommerce/features/products/data/models/list_product_by_remark_model.dart';
import 'package:get/get.dart';

class ListProductByRemarkController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ListProductByRemarkModel> _newProducts = [];
  List<ListProductByRemarkModel> get newProducts => _newProducts;

  List<ListProductByRemarkModel> _specialProducts = [];
  List<ListProductByRemarkModel> get specialProducts => _specialProducts;

  List<ListProductByRemarkModel> _popularProducts = [];
  List<ListProductByRemarkModel> get popularProducts => _popularProducts;


  Future<bool> getListProductByRemark(String remark) async {
    _inBuffer = true;
    update();

    final NetworkResponse networkResponse =
    await Get.find<NetworkCaller>().getRequest(
      url: Urls.listProductByRemarkUrl(remark),
    );

    if (networkResponse.isSuccess) {
      _errorMessage = null;

      final List<ListProductByRemarkModel> list = [];

      for (Map<String, dynamic> jsonData
      in networkResponse.body!['data']) {
        list.add(
          ListProductByRemarkModel.fromJson(jsonData),
        );
      }

      if (remark == 'new') {
        _newProducts = list;
      } else if (remark == 'special') {
        _specialProducts = list;
      } else if (remark == 'popular') {
        _popularProducts = list;
      }

      _inBuffer = false;
      update();

      return true;
    }

    _inBuffer = false;
    update();

    return false;
  }
}