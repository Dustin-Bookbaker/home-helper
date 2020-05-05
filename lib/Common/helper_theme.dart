import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class HelperTheme extends StatelessWidget {
  final ThemedWidgetBuilder childBuilder;
  const HelperTheme({@required this.childBuilder});

  @override
  Widget build(BuildContext context) => DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
          iconTheme: IconThemeData(color: Colors.blueGrey),
          brightness: Brightness.light,
          primarySwatch: Colors.lightGreen,
          primaryColor: Colors.white,
          cursorColor: Colors.blue,
          accentColor: Color.fromARGB(255, 1, 68, 87),
          backgroundColor: Color.fromRGBO(243, 243, 243, 1.0),
          textTheme: TextTheme(
            body1: TextStyle(
              color: Colors.blueGrey[800],
            ),
            body2: TextStyle(
              color: Colors.blueGrey[800],
            ),
            button: TextStyle(
              color: Colors.blueGrey[800],
            ),
            overline: TextStyle(
              color: Colors.blueGrey[800],
            ),
            subtitle: TextStyle(
              color: Colors.blueGrey[800],
            ),
            title: TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            headline: TextStyle(
              color: Colors.blueGrey[500],
            ),
            caption: TextStyle(
              color: Colors.blueGrey[800],
            ),
            display1: TextStyle(
              color: Colors.blueGrey[800],
            ),
            display2: TextStyle(
              color: Colors.blueGrey[800],
            ),
            display3: TextStyle(
              color: Colors.blueGrey[800],
            ),
            display4: TextStyle(
              color: Colors.blueGrey[800],
            ),
            subhead: TextStyle(
              color: Colors.blueGrey[800],
            ),
          ),
        ),
        themedWidgetBuilder: childBuilder,
      );
}
