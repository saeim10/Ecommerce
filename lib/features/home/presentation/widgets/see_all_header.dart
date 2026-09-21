import 'package:craftybay_ecommerce/app/theme/app_colors.dart';
import 'package:craftybay_ecommerce/app/localization/localization_extension.dart';
import 'package:flutter/material.dart';
class SeeAllHeader extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SeeAllHeader({
    super.key,
    required this.text, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            context.localization.see_all,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.themeColor
            ),
          ),
        ),
      ],
    );
  }
}
