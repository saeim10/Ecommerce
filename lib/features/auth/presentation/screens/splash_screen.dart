import 'package:craftybay_ecommerce/app/localization/localization_extension.dart';
import 'package:craftybay_ecommerce/app/utils/app_version.dart';
import 'package:craftybay_ecommerce/features/common/assets_path/assets_path.dart';
import 'package:craftybay_ecommerce/navigation/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, MainNavigationScreen.name);
  }
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SvgPicture.asset(AssetsPath.logoSvg),
            Spacer(),
            CircularProgressIndicator(),
            const SizedBox(height: 16,),
            Text('${context.localization.version} ${AppVersion.currentAppVersion}',style: TextStyle(fontSize: 20),),
            const SizedBox(height: 32,)

          ],
        ),
      ),
    );
  }
}
