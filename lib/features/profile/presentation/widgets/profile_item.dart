import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF29234A)
                  : const Color(0xFFF1F0FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: isDark
                  ? const Color(0xFFB8A9FF)
                  : const Color(0xFF5741B8),
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}