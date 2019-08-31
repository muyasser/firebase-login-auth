import 'package:firebase_auth_login/auth.dart';
import 'package:firebase_auth_login/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/login_page.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements BaseAuth {}

Widget makeTestableWidget({Widget child, BaseAuth auth}) {
  return AuthProvider(
    auth: auth,
    child: MaterialApp(
      home: child,
    ),
  );
}

void main() {
  // test sign in callback not called if email and password is empty
  testWidgets('email or password is empty, does not sign in',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();

    LoginPage page = LoginPage();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await tester.tap(find.byKey(Key('logIn')));

    verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
  });

  // test sign in callback is called if email and password are not empty and valid
  testWidgets('email and password are valid empty, sign in succeed',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password'))
        .thenAnswer((_) => Future.value('uid'));

    LoginPage page = LoginPage();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('logIn')));

    verify(mockAuth.signInWithEmailAndPassword('email', 'password')).called(1);
  });

  // test sign in callback is called if email and password are not empty and also not valid
  testWidgets('email and password are valid empty, sign in failed',
      (WidgetTester tester) async {
    MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password'))
        .thenThrow(StateError('Invalid credentials'));

    bool didSignIn = false;

    LoginPage page = LoginPage(
      onSignedIn: () => didSignIn = true,
    );

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('logIn')));

    verify(mockAuth.signInWithEmailAndPassword('email', 'password')).called(1);

    expect(didSignIn, false);
  });
}
