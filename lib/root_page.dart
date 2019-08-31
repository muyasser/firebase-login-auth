import 'package:firebase_auth_login/auth.dart';
import 'package:firebase_auth_login/auth_provider.dart';
import 'package:firebase_auth_login/home_page.dart';
import 'package:firebase_auth_login/login_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;

    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool isLoggedIn = snapshot.hasData;

          return isLoggedIn ? HomePage() : LoginPage();
        }

        return _buildWaitingascreen();
      },
    );
  }

  Widget _buildWaitingascreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
