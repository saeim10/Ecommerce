import 'package:craftybay_ecommerce/app/theme/app_colors.dart';
import 'package:craftybay_ecommerce/features/carts/presentation/controllers/cart_controller.dart';
import 'package:craftybay_ecommerce/features/carts/presentation/controllers/delete_cart_controller.dart';
import 'package:craftybay_ecommerce/features/carts/presentation/widgets/quantity_button.dart';
import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/navigation/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String name = '/cart-screen';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CartController>().getCartList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainNavigationScreen.name);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Cart List'),
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          if (controller.inBuffer) {
            return CenterCircularProgressIndicator();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controller.cartList.length,
            itemBuilder: (context, index) {
              final cartItem = controller.cartList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                elevation: 2,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Product Image
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.network(
                          cartItem.product.image,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Product Information
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title + Delete
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartItem.product.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  GetBuilder<DeleteCartController>(
                                    builder: (deleteController) {
                                      return IconButton(
                                        onPressed: () async {
                                          final success = await deleteController.deleteCartItem(
                                            cartItem.productId,
                                          );

                                          if (!mounted) return;

                                          if (success) {
                                            await Get.find<CartController>().getCartList();
                                          }
                                        },
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 34,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  )                                ],
                              ),

                              const SizedBox(height: 4),

                              // Color + Size
                              Text(
                                'Color: ${cartItem.color}, Size: ${cartItem.size}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),

                              const Spacer(),

                              // Price + Quantity
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Price
                                  Text(
                                    '৳${cartItem.price}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.themeColor,
                                    ),
                                  ),

                                  // Quantity
                                  Row(
                                    children: [
                                      QuantityButton(
                                        icon: Icons.remove,
                                        onPressed: () {},
                                        color: AppColors.themeColor.withOpacity(0.55),
                                      ),

                                      const SizedBox(width: 8),

                                     Text(
                                       '${cartItem.qty}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      QuantityButton(
                                        icon: Icons.add,
                                        onPressed: () {},
                                        color: AppColors.themeColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }

}
