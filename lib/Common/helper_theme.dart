import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class HelperTheme extends StatelessWidget {
  final ThemedWidgetBuilder childBuilder;
  const HelperTheme({@required this.childBuilder});

  @override
  Widget build(BuildContext context) => DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
          iconTheme: IconThemeData(color: Colors.lightGreen[500]),
          scaffoldBackgroundColor: Colors.lightGreen[50],
          dialogBackgroundColor: Colors.lightGreen[50],
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          primaryColor: Colors.lightGreen[400],
          cursorColor: Colors.lightGreen[700],
          accentColor: Colors.lightGreen[500],
          backgroundColor: Colors.lightGreen[50],
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
