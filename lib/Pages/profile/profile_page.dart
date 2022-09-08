import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehelper/Bloc/auth/auth_bloc.dart';
import 'package:homehelper/Bloc/user/user_bloc.dart';
import 'package:homehelper/Common/constants/routing_constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(360)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      state.helperUser.imagePath,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7.5,
                              horizontal: 30,
                            ),
                            child: Text(
                              state.helperUser.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text('Punkte'),
                            trailing: Text('${state.helperUser.score}'),
                          ),
                          ListTile(
                            title: Text('Bewertung'),
                            trailing: Text('${state.helperUser.rating}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: state.helperUser.imagePath == ''
                        ? Text('Profilbild hinzufügen')
                        : Text('Profilbild ändern'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(profilePictureRoute);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
