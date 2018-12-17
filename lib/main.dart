import 'package:flutter/material.dart';
import 'package:flutter_login_sample/pages/home_page.dart';
import 'package:flutter_login_sample/pages/login/login_page.dart';
import 'package:flutter_login_sample/pages/signup/sign_up_page.dart';

void main() => runApp(new MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/signUp': (BuildContext context) => new SignUpPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login Sample App',
      theme: new ThemeData(primarySwatch: Colors.blue),
      routes: routes,
    );
  }
}
