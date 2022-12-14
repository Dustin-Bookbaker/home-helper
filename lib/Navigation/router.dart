import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:homehelper/Pages/authenticate/login/login_screen.dart';
import 'package:homehelper/Pages/home/home_settings_page.dart';
import 'package:homehelper/Pages/profile/profile_picture_page.dart';
import 'package:homehelper/Pages/splash_page.dart';
import 'package:homehelper/Pages/ticket/create_ticket_page.dart';
import 'package:homehelper/Pages/ticket/ticket_page.dart';
import 'package:homehelper/repositories/user/user_repository.dart';

import 'Bottom_navigation/bottom_navigation.dart';

/// RouteHandler which is called with every Navigator call.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case mainRoute:
      return MaterialPageRoute(
        builder: (_) => SplashPage(),
      );

    case signInRoute:
      return MaterialPageRoute(
        builder: (context) => LoginScreen(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
      );

    case homeRoute:
      return MaterialPageRoute(
        builder: (context) => BottomNavigation(
          tab: TabItem.home,
        ),
      );

    case homeProfileRoute:
      return MaterialPageRoute(
        builder: (context) => BottomNavigation(
          tab: TabItem.profile,
        ),
      );
    case homeSettingsRoute:
      return MaterialPageRoute(
        builder: (context) => HomeSettingsPage(),
      );
    case ticketRoute:
      return MaterialPageRoute(
        builder: (context) => TicketPage(ticket: settings.arguments),
      );
    case createTicketRoute:
      return MaterialPageRoute(
        builder: (context) => CreateTicketPage(),
      );
    case profilePictureRoute:
      return MaterialPageRoute(
        builder: (context) => ProfilePicturePage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => BottomNavigation(
          tab: TabItem.home,
        ),
      );
  }
}
