import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String statustime;
  String name;
  String surname;
  String uid;
  String id;
  String Date;
  String Location;
  String Price;
  String Type;
  String Lastdate;
  String aboutme;

  Status({
    this.statustime,
    this.name,
    this.surname,
    this.uid,
    this.id,
    this.Date,
    this.Location,
    this.Price,
    this.Type,
    this.Lastdate,
    this.aboutme,
  });
  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
      statustime: snapshot["statustime"],
      name: snapshot["name"],
      surname: snapshot["sunrmae"],
      uid: snapshot["uid"],
      id: snapshot.id,
      Date: snapshot["Date"],
      Location: snapshot["Location"],
      Price: snapshot["Price"],
      Type: snapshot["Type"],
      Lastdate: snapshot["lastdate"],
      aboutme: snapshot["Aboutme"],
    );
  }
}
