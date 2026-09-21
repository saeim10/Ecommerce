import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/features/products/presentation/controllers/list_product_by_remark_controller.dart';
import 'package:craftybay_ecommerce/features/products/presentation/widgets/remark_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SpecialProductScreen extends StatefulWidget {
  const SpecialProductScreen({super.key});
static const String name ='/special-screen';
  @override
  State<SpecialProductScreen> createState() => _SpecialProductScreenState();
}

class _SpecialProductScreenState extends State<SpecialProductScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ListProductByRemarkController>()
        .getListProductByRemark('special');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Special'),
      ),
      body: GetBuilder<ListProductByRemarkController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inBuffer == false,
            replacement: CenterCircularProgressIndicator(),
            child: GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: controller.specialProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 4 columns per row
                  mainAxisSpacing: 30, // Vertical spacing between rows
                  crossAxisSpacing: 12, // Horizontal spacing between columns
                  childAspectRatio: 0.52, // Adjusts height-to-width ratio of each grid cell
                ),
                itemBuilder: (context,index){
                  final remarkProduct = controller.specialProducts[index];
                  return RemarkProduct(remarkProduct: remarkProduct,);
                }
            ),
          );
        }
      ),
    );
  }
}
