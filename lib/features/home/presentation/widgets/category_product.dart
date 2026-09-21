import 'package:flutter/material.dart';
class CategoryProduct extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String name;

  const CategoryProduct({
    super.key,
    required this.onTap,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF00B8A9),
            ),
          ),
        ],
      ),
    );
  }
}