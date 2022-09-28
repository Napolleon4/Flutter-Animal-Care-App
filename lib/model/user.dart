import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String surname;
  String email;
  String password;

  User({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    String uid,
  });
  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      id: snapshot.id,
      name: snapshot["name"],
      surname: snapshot["surname"],
      email: snapshot["email"],
      password: snapshot["password"],
    );
  }
}
