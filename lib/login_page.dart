import 'package:firebase_auth_login/auth_provider.dart';
import 'package:flutter/material.dart';

class EmailFieldValidator {
  static String validate(String value) =>
      value.isEmpty ? 'Email can\'t be empty' : null;
}

class PasswordFieldValidator {
  static String validate(String value) =>
      value.isEmpty ? 'Password can\'t be empty' : null;
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  FormType _formType = FormType.login;

  final formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          String userId =
              await auth.signInWithEmailAndPassword(_email, _password);

          print('Signed in: $userId');
        } else {
          final userId =
              await auth.createUserWithEmailAndPassword(_email, _password);

          print('Registered user: $userId');
        }
      } catch (error) {
        print('Error: $error');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Login Demo'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInput() + buildSubmitButtons(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInput() {
    return [
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: EmailFieldValidator.validate,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          key: Key('logIn'),
          child: Text('Login'),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Create an account'),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        RaisedButton(
          child: Text('Create an account'),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Have an account? Login'),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
