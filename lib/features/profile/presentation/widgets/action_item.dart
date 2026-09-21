import 'package:flutter/material.dart';

class ActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            trailing ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 17,
                  color: colorScheme.onSurfaceVariant,
                ),
          ],
        ),
      ),
    );
  }
}