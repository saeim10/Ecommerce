import 'package:craftybay_ecommerce/app/utils/urls.dart';
import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:craftybay_ecommerce/core/service/network_caller.dart';
import 'package:craftybay_ecommerce/features/auth/data/models/auth_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  bool _inBuffer = false;
  bool get inBuffer => _inBuffer;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthModel? _authModel;
  AuthModel? get authModel => _authModel;

  Future<bool> getAuth(String email) async {
    bool isSuccess = false;
    _inBuffer = true;
    update();
    NetworkResponse networkResponse = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.signInUrl(email));

    if(networkResponse.isSuccess){
      _authModel = AuthModel.fromJson(networkResponse.body!);
      isSuccess = true;
      _errorMessage = null;
    }
    else{
      _errorMessage = networkResponse.errorMessage;
    }
    _inBuffer = false;
    update();
    return isSuccess;
  }
}
