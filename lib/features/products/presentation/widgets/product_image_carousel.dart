import 'package:carousel_slider/carousel_slider.dart';
import 'package:craftybay_ecommerce/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    super.key,
    required this.imageUrls,
  });

  final List<String> imageUrls;

  @override
  State<ProductImageCarousel> createState() =>
      _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
          ),
          items: widget.imageUrls.map((image) {
            return Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainer,
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.scaleDown,
                ),
              ),
            );
          }).toList(),
        ),

        // Dots
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                  i < widget.imageUrls.length;
                  i++)
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: value == i
                            ? AppColors.themeColor
                            : null,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }
}