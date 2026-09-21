import 'package:craftybay_ecommerce/app/localization/localization_extension.dart';
import 'package:craftybay_ecommerce/features/category/presentation/screens/categories_screen.dart';
import 'package:craftybay_ecommerce/features/category/presentation/screens/list_product_by_category_screen.dart';
import 'package:craftybay_ecommerce/features/common/assets_path/assets_path.dart';
import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/features/home/presentation/controllers/category_list_controller.dart';
import 'package:craftybay_ecommerce/features/home/presentation/widgets/category_product.dart';
import 'package:craftybay_ecommerce/features/home/presentation/controllers/home_slider_controller.dart';
import 'package:craftybay_ecommerce/features/home/presentation/widgets/home_slider.dart';
import 'package:craftybay_ecommerce/features/home/presentation/widgets/see_all_header.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/new_product_screen.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/popular_product_screen.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/special_product_screen.dart';
import 'package:craftybay_ecommerce/features/products/presentation/widgets/remark_product.dart';
import 'package:craftybay_ecommerce/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../products/presentation/controllers/list_product_by_remark_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = '/Home-Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late CategoryListController categoryController;

  @override
  void initState() {
    super.initState();

    categoryController = Get.put(
      CategoryListController(),
      tag: 'homeCategory',
    );

    Get.find<HomeSliderController>().getHomeSlider();
    categoryController.categories();
    final newProductController = Get.put(
      ListProductByRemarkController(),
      tag: 'newProduct',
    );

    newProductController.getListProductByRemark('new');

    final popularProductController = Get.put(
      ListProductByRemarkController(),
      tag: 'popularProduct',
    );

    popularProductController.getListProductByRemark('popular');

    final specialProductController = Get.put(
      ListProductByRemarkController(),
      tag: 'specialProduct',
    );

    specialProductController.getListProductByRemark('special');

  }

  @override
  void dispose() {
    Get.delete<CategoryListController>(tag: 'homeCategory');

      Get.delete<ListProductByRemarkController>(
        tag: 'newProduct',
      );
    Get.delete<ListProductByRemarkController>(
      tag: 'specialProduct',
    );
    Get.delete<ListProductByRemarkController>(
      tag: 'popularProduct',
    );
      super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AssetsPath.logoNavSvg),
        actions: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: IconButton(onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.name);
            }, icon: Icon(Icons.person)),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_active_rounded),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: context.localization.search,
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1E1E1E) // Dark surface
                      : Colors.grey.shade100,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GetBuilder<HomeSliderController>(
                builder: (controller) {

                  return HomeSlider(sliders: controller.listSlider,);
                }
              ),
              const SizedBox(height: 4),


              const SizedBox(height: 16),
              SeeAllHeader(
                text: context.localization.all_categories,
                onTap: () {
                  Navigator.pushReplacementNamed(context, CategoriesScreen.name);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.maxFinite,
                height: 150,
                child: GetBuilder<CategoryListController>(
                    tag: 'homeCategory',
                    builder: (controller) {
                    return Visibility(
                      visible: controller.inBuffer == false,
                      replacement: CenterCircularProgressIndicator(),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categoryList.length,
                        separatorBuilder: (context, index) => SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          final category = controller.categoryList[index];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 90,
                                height: 110,
                                child: CategoryProduct(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ListProductByCategoryScreen.name,
                                      arguments: {
                                        'categoryId': category.id,
                                        'categoryName': category.categoryName,
                                      },
                                    );
                                  },
                                  image: category.categoryImg,
                                  name: category.categoryName,
                                ),
                              ),

                            ],
                          );
                        },
                      ),
                    );
                  }
                ),
              ),
              const SizedBox(height: 16),
              SeeAllHeader(text: context.localization.popular, onTap: () {
                Navigator.pushNamed(context, PopularProductScreen.name);
              }),
              _buildPopularDisplayProduct('popularProduct'),
              const SizedBox(height: 16),
              SeeAllHeader(text: context.localization.special, onTap: () {
                Navigator.pushNamed(context, SpecialProductScreen.name);
              }),
              _buildSpecialDisplayProduct('specialProduct'),
              const SizedBox(height: 16),
              SeeAllHeader(text: context.localization.neww, onTap: () {
                Navigator.pushNamed(context, NewProductScreen.name);
              }),
              _buildNewDisplayProduct('newProduct'),
              const SizedBox(height: 52),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildNewDisplayProduct(String remark) {
    return GetBuilder<ListProductByRemarkController>(
      tag: remark,
      builder: (controller) {
        return SizedBox(
          width: double.maxFinite,
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.newProducts.length,
            separatorBuilder: (context, index) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product =
              controller.newProducts[index];
              return RemarkProduct(remarkProduct: product,);
            },
          ),
        );
      }
    );
  }
  Widget _buildPopularDisplayProduct(String remark) {
    return GetBuilder<ListProductByRemarkController>(
        tag: remark,
        builder: (controller) {
          return SizedBox(
            width: double.maxFinite,
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.popularProducts.length,
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product =
                controller.popularProducts[index];
                return RemarkProduct(remarkProduct: product,);
              },
            ),
          );
        }
    );
  }
  Widget _buildSpecialDisplayProduct(String remark) {
    return GetBuilder<ListProductByRemarkController>(
        tag: remark,
        builder: (controller) {
          return SizedBox(
            width: double.maxFinite,
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.specialProducts.length,
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product =
                controller.specialProducts[index];
                return RemarkProduct(remarkProduct: product,);
              },
            ),
          );
        }
    );
  }


}

