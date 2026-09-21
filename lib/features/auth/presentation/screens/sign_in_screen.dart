import 'package:craftybay_ecommerce/app/theme/app_colors.dart';
import 'package:craftybay_ecommerce/app/localization/localization_extension.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/controllers/auth_controller.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:craftybay_ecommerce/features/common/assets_path/assets_path.dart';
import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/features/common/widgets/show_snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 120),
            child: Column(
              children: [
                SvgPicture.asset(AssetsPath.logoSvg, width: 120),
                const SizedBox(height: 16),
                Text(
                  context.localization.welcome_back,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  context.localization.please_enter_email,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email Address'),
                ),
                const SizedBox(height: 16),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inBuffer == false,
                      replacement: CenterCircularProgressIndicator(),
                      child: FilledButton(
                        onPressed: () async {
                          final email = _emailTEController.text.trim();

                          if (email.isEmpty) {
                            showSnackBar(context, 'Enter your email');
                            return;
                          }

                          final success = await controller.getAuth(email);
                          if (!mounted) return;

                          if (success) {
                            Navigator.pushReplacementNamed(
                              context,
                              VerifyOtpScreen.name,
                              arguments: email,
                            );
                          } else {
                            showSnackBar(
                              context,
                              controller.errorMessage ?? 'Something went wrong',
                            );
                          }
                        },
                        child: Text('Next', style: TextStyle(fontSize: 18)),
                      ),
                    );
                  }
                ),
                const SizedBox(height: 32),
                RichText(
                  text: TextSpan(
                    text: context.localization.dont_have_an_account,
                    style: Theme.of(context).textTheme.displayMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          Navigator.pushNamed(context, SignUpScreen.name);
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
