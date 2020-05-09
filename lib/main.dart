import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/auth/auth_bloc.dart';
import 'package:homehelper/Bloc/login/login_bloc.dart';
import 'package:homehelper/Bloc/register/register_bloc.dart';

import 'package:homehelper/Common/constants/routing_constants.dart';
import 'package:homehelper/repositories/user/user_repository.dart';
import 'Common/helper_theme.dart';
import 'Navigation/router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) => HelperTheme(
        childBuilder: (context, theme) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) =>
                    AuthenticationBloc(userRepository: UserRepository()),
                lazy: false,
              ),
              BlocProvider<LoginBloc>(
                create: (context) =>
                    LoginBloc(userRepository: UserRepository()),
                lazy: false,
              ),
              BlocProvider<RegisterBloc>(
                create: (context) =>
                    RegisterBloc(userRepository: UserRepository()),
              )
            ],
            child: MaterialApp(
              navigatorKey: _navigatorKey,
              theme: theme,
              title: "homeHelper",
              builder: (_, widget) {
                return widget;
              },
              initialRoute: mainRoute,
              onGenerateRoute: router.generateRoute,
            ),
          ),
        ),
      );
}
