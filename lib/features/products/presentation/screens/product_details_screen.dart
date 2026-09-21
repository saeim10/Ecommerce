import 'package:craftybay_ecommerce/app/theme/app_colors.dart';
import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/features/products/presentation/controllers/create_cart_controller.dart';
import 'package:craftybay_ecommerce/features/products/presentation/controllers/product_details_controller.dart';
import 'package:craftybay_ecommerce/features/products/presentation/widgets/color_and_size.dart';
import 'package:craftybay_ecommerce/features/products/presentation/widgets/product_image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../app/utils/global.dart';
import '../../../auth/presentation/controllers/auth_session_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedIndex = 0;
  String? selectedColor;
  String? selectedSize;
  int quantity = 1;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      Get.find<ProductDetailsController>().getProductDetails(productId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),

      body: GetBuilder<ProductDetailsController>(
        builder: (controller) {

          if (controller.inBuffer) {
            return const CenterCircularProgressIndicator();
          }


          if (controller.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  controller.errorMessage!,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (controller.productDetailsList.isEmpty) {
            return const Center(
              child: Text(
                'Product details not found',
                style: TextStyle(fontSize: 18),
              ),
            );
          }


          final productDetails = controller.productDetailsList.first;

          final product = productDetails.product;


          final List<String> imageUrls = [
            if (productDetails.img1 != null && productDetails.img1!.isNotEmpty)
              productDetails.img1!,

            if (productDetails.img2 != null && productDetails.img2!.isNotEmpty)
              productDetails.img2!,

            if (productDetails.img3 != null && productDetails.img3!.isNotEmpty)
              productDetails.img3!,

            if (productDetails.img4 != null && productDetails.img4!.isNotEmpty)
              productDetails.img4!,
          ];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ProductImageCarousel(imageUrls: imageUrls),

              const SizedBox(height: 16),


              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                product?.title ?? 'No title',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.displayLarge
                                    ?.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Quantity
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Plus
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.themeColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),

                                const SizedBox(width: 4),

                                Text(
                                  quantity.toString().padLeft(2, '0'),
                                  style: TextStyle(fontSize: 22),
                                ),

                                const SizedBox(width: 4),

                                // Minus
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.themeColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 32,
                              color: Colors.amber,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              ((product?.star ?? 0) / 20).toStringAsFixed(1),
                              style: const TextStyle(fontSize: 22),
                            ),

                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: AppColors.themeColor,
                                ),
                              ),
                            ),

                            const Spacer(),

                            const Icon(
                              Icons.favorite_border,
                              size: 28,
                              color: Color(0xFF00B8A9),
                            ),
                          ],
                        ),



                        Text(
                          'Color',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium,
                        ),

                        if (productDetails.color.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: productDetails.color.map(
                                  (color) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = color;
                                      }
                                      );
                                },
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    border: Border.all(
                                      color: selectedColor == color ? AppColors.themeColor : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ColorAndSize(
                                    text: color,
                                  ),
                                ),
                              ),
                            ).toList(),
                          )
                        else
                          const Text(
                            'No color available',
                          ),


                        if (selectedColor != null)
                          Text(
                            'Selected Color: $selectedColor',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),


                        Text(
                          'Size',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium,
                        ),

                        if (productDetails.size.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: productDetails.size
                                .map((size) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    border: Border.all(
                                      color:
                                      selectedSize == size ? AppColors.themeColor : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      8,
                                    ),
                                  ),
                                  child: ColorAndSize(
                                    text: size,
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                          )
                        else
                          const Text(
                            'No size available',
                          ),

                        if (selectedSize != null)
                          Text(
                            'Selected Size: $selectedSize',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),


                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),

                        Text(
                          productDetails.des ?? 'No description available',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),


              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.w600,
                                    fontSize: 24,
                                  ),
                                ),

                                Text(
                                  '৳${product?.price ?? '0'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                    color: AppColors
                                        .themeColor,
                                    fontSize: 22,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<CreateCartController>(
                      builder: (controller) {
                        return SizedBox(
                          width: 170,
                          child: FilledButton(
                            onPressed: controller.inBuffer ? null : () async {


                              // Token check
                              final token = AuthSessionController.accessToken;

                              if (token == null ||
                                  token.isEmpty ||
                                  JwtDecoder.isExpired(token)) {
                                await AuthSessionController.clearData();

                                Get.snackbar(
                                  'Session Expired',
                                  'Please sign in again.',
                                );

                                Get.offAllNamed(SignInScreen.name);
                                return;
                              }
                              if (productId == null) {
                                Get.snackbar('Error', 'Product ID not found');
                                return;
                              }

                              if (selectedColor == null) {
                                Get.snackbar('Error', 'Please select a color');
                                return;
                              }

                              if (selectedSize == null) {
                                Get.snackbar('Error', 'Please select a size');
                                return;
                              }

                              final success = await controller.createCart(
                                productId: productId!,
                                color: selectedColor!,
                                size: selectedSize!,
                                qty: quantity,
                                price: int.parse(product!.price!),
                              );

                              if (success) {
                                Get.snackbar(
                                  'Success',
                                  'Product added to cart',
                                );
                              } else {
                                Get.snackbar(
                                  "Error" ,
                                  controller.errorMessage!,
                                );
                              }
                            },
                            child: controller.inBuffer
                                ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}
