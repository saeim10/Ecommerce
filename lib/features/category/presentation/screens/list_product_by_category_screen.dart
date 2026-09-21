import 'package:craftybay_ecommerce/features/category/presentation/controllers/list_product_by_category_controller.dart';
import 'package:craftybay_ecommerce/features/category/presentation/widgets/product_display.dart';
import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ListProductByCategoryScreen extends StatefulWidget {
  const ListProductByCategoryScreen({super.key, required this.categoryId, required this.categoryName});
static const String name = '/display-product-screen';

  final int categoryId; final String categoryName;

  @override
  State<ListProductByCategoryScreen> createState() => _ListProductByCategoryScreenState();
}

class _ListProductByCategoryScreenState extends State<ListProductByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ListProductByCategoryController>().getProductByCategory(widget.categoryId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: GetBuilder<ListProductByCategoryController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress == false,
            replacement: CenterCircularProgressIndicator(),
            child: GridView.builder(
              padding: EdgeInsets.all(8),
                itemCount: controller.productCategoryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 4 columns per row
                  mainAxisSpacing: 30, // Vertical spacing between rows
                  crossAxisSpacing: 12, // Horizontal spacing between columns
                  childAspectRatio: 0.52, // Adjusts height-to-width ratio of each grid cell
                ),
                itemBuilder: (context,index){
                  final product = controller.productCategoryList[index];
                  return ProductDisplay(product: product,);
                }
            ),
          );
        }
      ),
    );
  }
}
