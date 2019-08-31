import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Stream<String> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map((user) => user?.uid);
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return authResult.user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult.user.uid;
  }

  Future<String> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();

    try {
      return user.uid;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
