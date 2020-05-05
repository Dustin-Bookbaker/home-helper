import 'package:flutter/material.dart';

import 'package:homehelper/Common/constants/routing_constants.dart';
import 'Navigation/router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: _navigatorKey,
        title: "homeHelper",
        builder: (_, widget) {
          return widget;
        },
        initialRoute: homeRoute,
        onGenerateRoute: router.generateRoute,
      );
}
