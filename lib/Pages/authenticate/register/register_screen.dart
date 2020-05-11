import 'package:flutter/material.dart';
import 'package:homehelper/Pages/authenticate/register/register_form.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    Key key,
  }) : super(key: key);

  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: RegisterForm(),
      ),
    );
  }
}
