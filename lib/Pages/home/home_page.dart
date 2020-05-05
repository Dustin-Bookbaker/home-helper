import 'package:flutter/material.dart';

import 'package:homehelper/Common/constants/routing_constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Home Helper'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.black,
              onPressed: () => Navigator.pushNamed(context, homeSettingsRoute),
            ),
          ],
        ),
        body: Center(
          child: Text('StartSeite'),
        ),
      );
}
