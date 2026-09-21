import 'package:flutter/material.dart';
class QuantityButton extends StatelessWidget {
  const QuantityButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconButton(
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}