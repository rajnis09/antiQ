import 'package:flutter/material.dart';

import '../utils/forms/registration_form.dart';
import '../views/category_page_view.dart';
import '../views/profile/profile_page.dart';
import '../views/splash_Screen.dart';
import '../views/shop_info.dart';
import '../views/error/error_page.dart';
import '../views/add_menu_items.dart';
import '../views/homepage.dart';
import '../views/ordered_history.dart';
import '../views/authentication/sign_in_page.dart';

import './routes.dart';

// TODO: Read
// All routes names are stored in routes.dart

class Router {
  static final Map<String, WidgetBuilder> routes = {
    Routes.splashScreenPage: (context) => SplashScreen(),
    Routes.signInPage: (context) => SignInPage(),
    Routes.registrationPage: (context) => Registration(),
    Routes.homePage: (context) => HomePage(),
    Routes.shopInfo: (context) => ShopInfo(),
    Routes.profilePage: (context) => ProfilePage(),
    Routes.orderHistory: (context) => OrderHistory(),
    Routes.addMenuItems: (context) => AddMenuItems(),
    Routes.categoryPageView: (context) => CategoryPageView(),
  };

  static Route<dynamic> unknownRoutes(RouteSettings settings) {
    print('Unknown Route name: ${settings.name}');
    return MaterialPageRoute(
      builder: (context) => ErrorPage(),
    );
  }
}
