import 'package:carousel_slider/carousel_slider.dart';
import 'package:craftybay_ecommerce/app/theme/app_colors.dart';
import 'package:craftybay_ecommerce/features/home/data/models/home_slider_model.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key, required this.sliders});
  final List<HomeSliderModel> sliders;
  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    if (widget.sliders.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 160,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              _currentIndex.value = index;
            },
          ),
          items: widget.sliders.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(slider.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.sliders.length; i++)
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value == i
                          ? AppColors.themeColor
                          : Colors.transparent,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
              ],
            );
          },
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
