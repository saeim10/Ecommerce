import 'package:craftybay_ecommerce/features/category/presentation/screens/list_product_by_category_screen.dart';
import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/features/home/presentation/controllers/category_list_controller.dart';
import 'package:craftybay_ecommerce/features/home/presentation/widgets/category_product.dart';
import 'package:craftybay_ecommerce/navigation/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static const String name = '/category-screen';
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoryListController categoryController;

  @override
  void initState() {
    super.initState();

    categoryController = Get.put(
      CategoryListController(),
      tag: 'categoriesScreen',
    );

    categoryController.categories();
  }

  @override
  void dispose() {
    Get.delete<CategoryListController>(tag: 'categoriesScreen');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainNavigationScreen.name);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Categories'),
      ),
      body: GetBuilder<CategoryListController>(
        tag: 'categoriesScreen',
        builder: (controller) {
          return Visibility(
            visible: controller.inBuffer == false,
            replacement: CenterCircularProgressIndicator(),
            child: GridView.builder(
              itemCount: controller.categoryList.length,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final category = controller.categoryList[index];
                return CategoryProduct(
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
                );
              },
            ),
          );
        }
      ),
    );
  }
}
