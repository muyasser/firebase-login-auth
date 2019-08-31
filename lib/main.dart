import 'package:firebase_auth_login/auth.dart';
import 'package:firebase_auth_login/auth_provider.dart';
import 'package:firebase_auth_login/login_page.dart';
import 'package:flutter/material.dart';
import 'root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Material App',
        home: RootPage(),
      ),
    );
  }
}
