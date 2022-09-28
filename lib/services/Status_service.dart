import 'package:flutter_application_4/model/Status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_4/services/Auth.dart';

class Statusservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStatus(
    String statustime,
    String name,
    String surname,
    String uid,
    String Date,
    String Location,
    String Price,
    String Type,
    String Lastdate,
    String aboutme,
  ) async {
    var ref = _firestore.collection("Status");

    var documentref = await ref.add({
      "statustime": statustime,
      "name": name,
      "surname": surname,
      "uid": uid,
      "Date": Date,
      "Location": Location,
      "Price": Price,
      "Type": Type,
      "lastdate": Lastdate,
      "Aboutme": aboutme,
    });
    Status(
      statustime: statustime,
      name: name,
      surname: surname,
      uid: uid,
      id: documentref.id,
      Date: Date,
      Location: Location,
      Price: Price,
      Type: Type,
      Lastdate: Lastdate,
      aboutme: aboutme,
    );
  }

  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore
        .collection("Status")
        .orderBy("statustime", descending: true)
        .snapshots();
    return ref;
  }

  Future<void> deleteStatus(String docId) {
    var ref = _firestore.collection("Status").doc(docId).delete();
    return ref;
  }
}
