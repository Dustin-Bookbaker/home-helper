import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/auth/auth_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => Scaffold(
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
            child: Column(
              children: <Widget>[
                Text(state.helperUser.name),
                Text(state.helperUser.email),
                Text('${state.helperUser.score}'),
                Text('${state.helperUser.rating}'),
              ],
            ),
          ),
        ),
      );
}
