import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/features/products/presentation/controllers/list_product_by_remark_controller.dart';
import 'package:craftybay_ecommerce/features/products/presentation/widgets/remark_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PopularProductScreen extends StatefulWidget {
  const PopularProductScreen({super.key});
 static const String name = 'popular-screen';
  @override
  State<PopularProductScreen> createState() => _PopularProductScreenState();
}

class _PopularProductScreenState extends State<PopularProductScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ListProductByRemarkController>()
        .getListProductByRemark('popular');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular'),
      ),
      body: GetBuilder<ListProductByRemarkController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inBuffer == false,
            replacement: CenterCircularProgressIndicator(),
            child: GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: controller.popularProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 4 columns per row
                  mainAxisSpacing: 30, // Vertical spacing between rows
                  crossAxisSpacing: 12, // Horizontal spacing between columns
                  childAspectRatio: 0.52, // Adjusts height-to-width ratio of each grid cell
                ),
                itemBuilder: (context,index){
                  final remarkProduct = controller.popularProducts[index];
                  return RemarkProduct(remarkProduct: remarkProduct,);
                }
            ),
          );
        }
      ),
    );
  }
}
