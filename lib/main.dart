import 'package:flutter/material.dart';

import 'package:homehelper/Common/constants/routing_constants.dart';
import 'Common/helper_theme.dart';
import 'Navigation/router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) => HelperTheme(
        childBuilder: (context, theme) => MaterialApp(
          navigatorKey: _navigatorKey,
          theme: theme,
          title: "homeHelper",
          builder: (_, widget) {
            return widget;
          },
          initialRoute: homeRoute,
          onGenerateRoute: router.generateRoute,
        ),
      );
}
