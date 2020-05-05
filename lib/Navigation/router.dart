import 'package:flutter/material.dart';

import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:homehelper/Pages/home/home_page.dart';
import 'package:homehelper/Pages/home/home_settings_page.dart';

import 'Bottom_navigation/bottom_navigation.dart';

/// RouteHandler which is called with every Navigator call.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(
        builder: (context) => BottomNavigation(
          tab: TabItem.home,
        ),
      );
    case homeSettingsRoute:
      return MaterialPageRoute(
        builder: (context) => HomeSettingsPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => BottomNavigation(
          tab: TabItem.home,
        ),
      );
  }
}
