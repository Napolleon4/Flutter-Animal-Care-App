// TODO Implement this library.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<User> createUserwithEmailPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<User> signinUserwithEmailPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<String> getCurrentId() async {
    String uid = await _firebaseAuth.currentUser.uid;
    return uid;
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  signout() async {
    return await _firebaseAuth.signOut();
  }
}
