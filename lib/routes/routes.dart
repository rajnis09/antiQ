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

class Router {
  static final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (context) => SplashScreen(),
    SignInPage.routeName: (context) => SignInPage(),
    Registration.routeName: (context) => Registration(),
    HomePage.routeName: (context) => HomePage(),
    ShopInfo.routeName: (context) => ShopInfo(),
    ProfilePage.routeName: (context) => ProfilePage(),
    OrderHistory.routeName: (context) => OrderHistory(),
    AddMenuItems.routeName: (context) => AddMenuItems(),
    CategoryPageView.routeName: (context) => CategoryPageView(),
  };

  static Route<dynamic> unknownRoutes(RouteSettings settings) {
    print('Unknown Route name: ${settings.name}');
    return MaterialPageRoute(
      builder: (context) => ErrorPage(),
    );
  }
}
