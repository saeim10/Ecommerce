import 'package:craftybay_ecommerce/features/category/data/model/list_product_by_category_model.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({super.key,  this.product});
  final ListProductByCategoryModel? product;

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  Widget build(BuildContext context) {
          return InkWell(
            onTap: (){
              Navigator.pushNamed(
                context,
                ProductDetailsScreen.name,
                arguments: widget.product?.id,
              );            },
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceBright, //dark
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Container(
                      height: 120, // reduced from 120
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.surfaceContainer, // dark
                      child: Image.network(
                        widget.product?.image ?? '',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 40,
                          );
                        },
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12,),
                         Text(
                          widget.product?.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 22),
                        Row(
                          children: [
                           Text(
                              '৳${widget.product?.price}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B8A9),
                              ),
                            ),
                            const SizedBox(width: 4),
                          Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 2),
                           Text(
                              widget.product?.star.toString() ?? '1',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: Color(0xFF00B8A9),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );


  }
}
