import 'package:flutter/material.dart';
class ColorAndSize extends StatelessWidget {
  final String text;
  const ColorAndSize({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          shape: BoxShape.circle
      ),
      child: Text(text),
    );
  }
}
