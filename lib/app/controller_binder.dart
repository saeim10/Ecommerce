
import 'package:craftybay_ecommerce/app/app.dart';
import 'package:craftybay_ecommerce/app/localization/language_controller.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/controllers/verify_otp_controller.dart';
import 'package:craftybay_ecommerce/features/carts/presentation/controllers/cart_controller.dart';
import 'package:craftybay_ecommerce/features/carts/presentation/controllers/delete_cart_controller.dart';
import 'package:craftybay_ecommerce/features/category/presentation/controllers/list_product_by_category_controller.dart';
import 'package:craftybay_ecommerce/features/home/presentation/controllers/home_slider_controller.dart';
import 'package:craftybay_ecommerce/features/products/presentation/controllers/create_cart_controller.dart';
import 'package:craftybay_ecommerce/features/products/presentation/controllers/list_product_by_remark_controller.dart';
import 'package:craftybay_ecommerce/features/products/presentation/controllers/product_details_controller.dart';
import 'package:get/get.dart';

import '../core/service/network_caller.dart';
import '../features/auth/presentation/controllers/auth_session_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    // Network Caller
    Get.put<NetworkCaller>(
      NetworkCaller(
        accessToken: () {
          return AuthSessionController.accessToken ?? '';

        },
      ),
    );
    Get.put(HomeSliderController());
    Get.put(ListProductByCategoryController());
    Get.put(ListProductByRemarkController());
    Get.put(LanguageController());
    Get.put(ProductDetailsController());
    Get.put(AuthController());
    Get.put(VerifyOtpController());
    Get.put(CartController());
    Get.put(CreateCartController());
    Get.put(DeleteCartController());


  }

}