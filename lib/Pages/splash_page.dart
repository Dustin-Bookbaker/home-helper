import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/auth/auth_bloc.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _awaitDialog = ValueNotifier<bool>(false);

  StreamSubscription<AuthenticationState> _authBlocSubscription;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.green[100],
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.25,
                ),
                child: FlareActor(
                  'assets/flare/Loading.flr',
                  animation: 'Alarm',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  callback: (_) => Future.delayed(
                    Duration(milliseconds: 100),
                    _navigate,
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                child: FlatButton(
                  child: Text(
                    "Ausloggen",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.orange),
                  ),
                  onPressed: _showLogoutDialog,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 32,
                  ),
                  child: Text(
                    "DEMO",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _navigate() {
    _awaitDialog.removeListener(_navigate);
    if (_awaitDialog.value) {
      _awaitDialog.addListener(_navigate);
    } else {
      _authBlocSubscription =
          BlocProvider.of<AuthenticationBloc>(context).listen((state) {
        switch (state.runtimeType) {
          case Authenticated:
            _authBlocSubscription.cancel();
            debugPrint('sending to Home!');
            Navigator.pushReplacementNamed(context, homeRoute);
            break;
          case Unauthenticated:
            _authBlocSubscription.cancel();
            debugPrint('sending to SignIn!');
            Navigator.pushReplacementNamed(context, signInRoute);
            break;
          default:
            _authBlocSubscription.cancel();
            debugPrint('sending to SignIn!');
            Navigator.pushReplacementNamed(context, signInRoute);
            break;
        }
      });
    }
  }

  void _showLogoutDialog() {
    _awaitDialog.value = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ausloggen'),
        content: Text('Bist Du Dir sicher, dass Du Dich ausloggen möchtest?'
            ' Likes, EXP und Level gehen dabei verloren!'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'AUSLOGGEN',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15.0,
              ),
            ),
            onPressed: () {
              _awaitDialog.value = false;
              RepositoryProvider.of<AuthenticationBloc>(context)
                  .add(LoggedOut());
            },
          ),
          FlatButton(
            child: Text(
              'ABBRECHEN',
              style: TextStyle(color: Colors.redAccent, fontSize: 15.0),
            ),
            onPressed: () {
              _awaitDialog.value = false;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
