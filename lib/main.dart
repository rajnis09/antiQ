import 'package:antiq/views/category_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './utils/forms/registration_form.dart';
import './providers/category_items_provider.dart';
import './providers/profile_provider.dart';
import './views/profile/profile.dart';
import './utils/theme/theme_data.dart';
import './views/splash_Screen.dart';
import './views/shop_info.dart';
import './views/error/error_page.dart';
import './providers/connectivity_provider.dart';
import './views/add_menu_items.dart';
import './views/bottom_navigation_bar.dart';
import './widgets/ordered_history.dart';
import './views/authentication/newsignin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            value: ConnectivityService().connectivityController.stream),
        ChangeNotifierProvider.value(value: CategoryItemsProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider()),
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
        home: CustomBottomNavigationBar(),
        routes: <String, WidgetBuilder>{
          // '/': (context) => SplashScreen(),
          '/logInPage': (context) => NewSignInPage(),
          '/registration': (context) => Registration(),
          '/homePage': (context) => CustomBottomNavigationBar(),
          '/shopInfo': (context) => ShopInfo(),
          '/profilepage': (context) => ProfilePage(),
          '/orderHistory': (context) => OrderedHistory(),
          AddMenuItems.routeName: (context) => AddMenuItems(),
          CategoryPageView.routeName: (context) => CategoryPageView(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => ErrorPage(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
