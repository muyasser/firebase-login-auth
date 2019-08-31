import 'package:firebase_auth_login/auth.dart';
import 'package:firebase_auth_login/auth_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  void _signedOut(BuildContext context) async {
    final auth = AuthProvider.of(context).auth;

    try {
      await auth.signOut();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _signedOut(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
