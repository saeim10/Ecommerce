import 'package:craftybay_ecommerce/app/theme/app_theme.dart';
import 'package:craftybay_ecommerce/app/controller_binder.dart';
import 'package:craftybay_ecommerce/app/localization/language_controller.dart';
import 'package:craftybay_ecommerce/app/theme/theme_controller.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/screens/splash_screen.dart';
import 'package:craftybay_ecommerce/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:craftybay_ecommerce/features/carts/presentation/screens/cart_screen.dart';
import 'package:craftybay_ecommerce/features/category/presentation/screens/categories_screen.dart';
import 'package:craftybay_ecommerce/features/category/presentation/screens/list_product_by_category_screen.dart';
import 'package:craftybay_ecommerce/features/home/presentation/screens/home_screen.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/new_product_screen.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/popular_product_screen.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/product_details_screen.dart';
import 'package:craftybay_ecommerce/features/products/presentation/screens/special_product_screen.dart';
import 'package:craftybay_ecommerce/features/profile/presentation/screens/profile_screen.dart';
import 'package:craftybay_ecommerce/features/wishlist/presentation/screens/wish_list_screen.dart';
import 'package:craftybay_ecommerce/l10n/app_localizations.dart';
import 'package:craftybay_ecommerce/navigation/main_navigation_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

static LanguageController languageController = LanguageController();
static ThemeController themeController = ThemeController();

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CraftyBay.languageController,
      builder: (language) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //Analytics firebase
          navigatorObservers: [observer],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: language.currentLocale,
          supportedLocales: language.supportedLanguages,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: CraftyBay.themeController.themeMode,
          initialBinding: ControllerBinding(),

          initialRoute: '/',
          routes: {
            /// Auth
            SplashScreen.name: (context) => SplashScreen(),
            SignInScreen.name: (context) => SignInScreen(),
            SignUpScreen.name: (context) => SignUpScreen(),
            VerifyOtpScreen.name: (context) => VerifyOtpScreen(),

            /// Home
            MainNavigationScreen.name: (context) => MainNavigationScreen(),
            ProductDetailsScreen.name: (context) => ProductDetailsScreen(),
            CategoriesScreen.name : (context) => CategoriesScreen(),
            ListProductByCategoryScreen.name: (context) {
              final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

              return ListProductByCategoryScreen(
                categoryId: args['categoryId'],
                categoryName: args['categoryName'],
              );
            },
            PopularProductScreen.name : (context) => PopularProductScreen(),
            CartScreen.name : (context) => CartScreen(),
            WishListScreen.name : (context) => WishListScreen(),
            NewProductScreen.name : (context) => NewProductScreen(),
            SpecialProductScreen.name : (context) => SpecialProductScreen(),
            HomeScreen.name : (context) => HomeScreen(),
            ProfileScreen.name : (context) => ProfileScreen()
          },

        );
      },
    );
  }
}
