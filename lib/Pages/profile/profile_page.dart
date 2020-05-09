import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/auth/auth_bloc.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Profil'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                Navigator.of(context).pushReplacementNamed(signInRoute);
              },
            )
          ],
        ),
        body: Center(
          child: Text('Profile Page'),
        ),
      );
}
