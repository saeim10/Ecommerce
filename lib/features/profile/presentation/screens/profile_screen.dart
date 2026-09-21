import 'package:craftybay_ecommerce/app/app.dart';
import 'package:craftybay_ecommerce/app/localization/language_controller.dart';
import 'package:craftybay_ecommerce/app/localization/localization_extension.dart';
import 'package:craftybay_ecommerce/app/localization/localization_string.dart';
import 'package:craftybay_ecommerce/features/profile/presentation/widgets/action_item.dart';
import 'package:craftybay_ecommerce/features/profile/presentation/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/theme/theme_controller.dart';
import '../../../auth/presentation/controllers/auth_session_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String name = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.localization.profile,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: theme.dividerColor,
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [

                      Container(
                        height: 92,
                        width: 92,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? const Color(0xFF29234A)
                              : const Color(0xFFEDE9FE),
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: 58,
                          color: isDark
                              ? const Color(0xFFB8A9FF)
                              : const Color(0xFF5741B8),
                        ),
                      ),

                      Positioned(
                        right: -2,
                        bottom: 0,
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.dividerColor,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 17,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Abdullah Al Saeim',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'saeim01@gmail.com',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Account
            Text(
              context.localization.account,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 14),

            ProfileItem(
              icon: Icons.person_outline_rounded,
              title: context.localization.name,
              value: 'Abdullah Al Saeim',
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.email_outlined,
              title: context.localization.email,
              value: 'saeim01@gmail.com',
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.phone_outlined,
              title: context.localization.phone,
              value: '+880 1841994232',
            ),

            const SizedBox(height: 30),

            // Preferences
            Text(
              context.localization.preferences,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 14),

            // Language
            GetBuilder<LanguageController>(
              init: CraftyBay.languageController,
              builder: (controller) {
                final isBangla =
                    controller.currentLocale ==
                        LocalizationString.languageBengali;

                return ActionItem(
                  icon: Icons.language_outlined,
                  title: context.localization.language,
                  subtitle: isBangla ? 'বাংলা' : 'English',
                  trailing: Switch(
                    value: isBangla,
                    onChanged: (value) {
                      controller.changeLanguage(
                        value
                            ? LocalizationString.languageBengali
                            : LocalizationString.languageEnglish,
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Theme
            GetBuilder<ThemeController>(
              init: CraftyBay.themeController,
              builder: (controller) {
                return ActionItem(
                  icon: Icons.dark_mode_outlined,
                  title: context.localization.theme,
                  subtitle: controller.isDarkMode ? 'Dark' : 'Light',
                  trailing: Switch(
                    value: controller.isDarkMode,
                    onChanged: (value) {
                      controller.changeTheme(value);
                    },
                  ),
                );
              },
            ),




            const SizedBox(height: 30),

            // Logout
            InkWell(
              onTap: () async {
                await AuthSessionController.clearData();

                if (!context.mounted) return;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.name,
                      (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF351D21)
                      : const Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF5A292F)
                        : const Color(0xFFFFD5D8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout_rounded,
                      color: Color(0xFFE5394F),
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      context.localization.logout,
                      style: TextStyle(
                        color: isDark
                            ? const Color(0xFFFF6B7A)
                            : const Color(0xFFE5394F),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}