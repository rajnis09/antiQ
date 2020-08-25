import 'package:antiq/providers/category_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import './utils/theme/theme_data.dart';
import './views/splash_Screen.dart';
import './views/authentication/signin_page.dart';
import './views/authentication/signUp_phone_page.dart';
import './views/error/error_page.dart';
import './providers/connectivity_provider.dart';
import './views/menu.dart';
import './views/edit_category.dart';
import './views/category.dart';
import './views/bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );

    return MultiProvider(
      providers: [
        StreamProvider<ConnectionStatus>.value(
          value: ConnectivityService().connectivityController.stream,
        ),
        ChangeNotifierProvider.value(
          value: CategoryItemsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'antiQ',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: CustomThemeData.robotoFont.copyWith(
              fontWeight: FontWeight.bold,
              color: CustomThemeData.blackColorShade2,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: CustomThemeData.blueColorShade2,
              ),
            ),
          ),
          cursorColor: CustomThemeData.blueColorShade2,
          textSelectionHandleColor: CustomThemeData.blueColorShade2,
          textSelectionColor: CustomThemeData.blueColorShade2,
          scaffoldBackgroundColor: Colors.white,
          accentColor: CustomThemeData.blueColorShade1,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(
              color: CustomThemeData.blackColorShade2,
            ),
            actionsIconTheme: IconThemeData(
              color: CustomThemeData.blackColorShade2,
            ),
            textTheme: TextTheme(
              headline6: CustomThemeData.robotoFont.copyWith(
                color: CustomThemeData.blackColorShade1,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: CustomThemeData.blueColorShade1,
          ),
        ),
        routes: <String, WidgetBuilder>{
          '/': (context) => LoginPage(),//SplashScreen(),
          '/logInPage': (context) => LoginPage(),
          '/signUpPhonePage': (context) => SignUpPhonePage(),
          '/homePage':(context)=>CustomBottomNavigationBar(),
          AddMenuItems.routeName: (context) => AddMenuItems(),
          Category.routeName: (context) => Category(),
          EditCategory.routeName: (context) => EditCategory(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => ErrorPage(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
