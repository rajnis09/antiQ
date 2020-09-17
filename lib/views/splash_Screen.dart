import 'package:antiq/providers/profile_provider.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../views/homepage.dart';
import '../views/authentication/sign_in_page.dart';
import '../utils/auth/auth_handler.dart';
import '../utils/theme/theme_data.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializingApplication();
  }

  void initializingApplication() async {
    Future.delayed(Duration(seconds: 1), () async {
      await Firebase.initializeApp();
      await authHandler.userReload();
      var user = authHandler.getCurrentUser();
      if (user != null) {
        final provider =
            Provider.of<ProfileServiceProvider>(context, listen: false);
        await provider.fetchLatestProfile();
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, SignInPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxHeight > constraints.maxWidth
              ? constraints.maxWidth
              : constraints.maxHeight;
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight / 2,
                ),
                Hero(
                  tag: 'splashLogoTag',
                  child: Container(
                    height: size * 0.5,
                    width: size * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/anitiQNobg.png'),
                      ),
                    ),
                  ),
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CustomThemeData.blueColorShade1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
