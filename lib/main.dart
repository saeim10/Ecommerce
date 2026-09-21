import 'package:craftybay_ecommerce/app/app.dart';
import 'package:craftybay_ecommerce/app/utils/app_version.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/controllers/auth_session_controller.dart';
import 'firebase_options.dart';

///Set up first before going to main part
//1. Crashlytics(firebase)
//2. Analytics(firebase)
//3. Localization
//4. Theme

///Crashlytics set up on main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

// Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
  };
  await AppVersion.getCurrentVersion(); //version of app
  await AuthSessionController.getToken();
  print('TOKEN BEFORE RUN APP: ${AuthSessionController.accessToken}');


  runApp(const CraftyBay());
}



