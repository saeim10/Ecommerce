import 'package:craftybay_ecommerce/features/auth/presentation/controllers/auth_session_controller.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/controllers/verify_otp_controller.dart';
import 'package:craftybay_ecommerce/features/common/assets_path/assets_path.dart';
import 'package:craftybay_ecommerce/features/common/widgets/center_circular_progress_indicator.dart';
import 'package:craftybay_ecommerce/features/common/widgets/show_snackbar.dart';
import 'package:craftybay_ecommerce/navigation/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  static const String name = '/otp-screen';

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final PinInputController _verifyOtpTEController = PinInputController();
  @override
  void dispose() {
    super.dispose();
    _verifyOtpTEController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 120),
          child: Column(
            children: [
              SvgPicture.asset(AssetsPath.logoSvg),
              const SizedBox(height: 16),
              Text(
                'Enter Otp Code',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'A 6 digit otp has been sent',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 16),
              MaterialPinField(
                  length: 6,
                pinController: _verifyOtpTEController,

              ),
              const SizedBox(height: 16),
              GetBuilder<VerifyOtpController>(
                builder: (otpController) {
                  return Visibility(
                    visible: otpController.inBuffer == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: FilledButton(
                      onPressed: () async {
                        final otp = _verifyOtpTEController.text.trim();
                        if (otp.length != 6) {
                          showSnackBar(context, 'Enter 6 digit OTP');
                          return;
                        }
                        final success = await otpController.verifyOtp(
                          email,
                          otp,
                        );
                        if (!mounted) return;
                        if (success) {
                          await AuthSessionController.saveToken(
                            otpController.authModel!.data,
                          );
                          showSnackBar(context, otpController.authModel!.msg);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            MainNavigationScreen.name,
                            (_) => false,
                          );
                        } else {
                          showSnackBar(
                            context,
                            otpController.errorMessage ?? 'Invalid OTP',
                          );
                        }
                      },
                      child: Text('Verify'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
