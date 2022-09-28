import 'package:flutter_application_4/model/Status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_4/profilepage.dart';

import '../model/user.dart';

class Userservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(
    String uid,
    String name,
    String surname,
    String email,
    String password,
  ) async {
    var ref = _firestore.collection("Users");

    var documentref = await ref.add({
      "uid": uid,
      "name": name,
      "surname": surname,
      "email": email,
      "password": password,
    });
    User(
      id: documentref.id,
      uid: uid,
      name: name,
      surname: surname,
      email: email,
      password: password,
    );
  }

  Stream<QuerySnapshot> getuserStatus() {
    var ref = _firestore.collection("Users").snapshots();
    return ref;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getuserspStatus() {
    var ref = _firestore
        .collection("Users")
        .where(
          "uid",
          isEqualTo: currentuser.currentUser.uid,
        )
        .snapshots();
    return ref;
  }

  final String userCollection =
      FirebaseFirestore.instance.collection("Users").id;
  Future<void> updatePasswordd(String password) async {
    await _firestore.doc(userCollection).update({"password": password});
  }
}
