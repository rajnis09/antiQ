import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import './routes/routes.dart';
import './providers/provider_service.dart';
import './utils/theme/app_theme.dart';

void main() => runApp(MyApp());

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
      providers: ProviderService.mainMultiProviders,
      child: MaterialApp(
        title: 'antiQ',
        theme: Themes.appTheme,
        routes: Router.routes,
        onUnknownRoute: Router.unknownRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
