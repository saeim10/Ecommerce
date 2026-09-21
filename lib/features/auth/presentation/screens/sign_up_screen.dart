import 'package:craftybay_ecommerce/app/theme/app_colors.dart';
import 'package:craftybay_ecommerce/app/localization/localization_extension.dart';
import 'package:craftybay_ecommerce/features/common/assets_path/assets_path.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
            child: Column(
              children: [
                SvgPicture.asset(AssetsPath.logoSvg, width: 120),
                const SizedBox(height: 16),
                Text(
                  context.localization.complete_profile,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  context.localization.get_started,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email Address'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Phone'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'City'),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {},
                  child: Text('Next', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 32),
                RichText(
                  text: TextSpan(
                    text: context.localization.have_an_account,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}
