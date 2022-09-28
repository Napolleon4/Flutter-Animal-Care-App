import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:flutter_application_4/userProfilepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class profilePage_Settings extends StatefulWidget {
  const profilePage_Settings({Key key}) : super(key: key);

  @override
  State<profilePage_Settings> createState() => _profilePage_SettingsState();
}

class _profilePage_SettingsState extends State<profilePage_Settings> {
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(children: [
            CircleAvatar(
              radius: 60,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                iconSize: 15,
                icon: FaIcon(FontAwesomeIcons.pen),
                onPressed: () {},
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                fillColor: Color.fromARGB(222, 255, 255, 255),
                filled: true,
                icon: Icon(Icons.person_add, color: Colors.black),
                hintText: "Name",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: surname,
              decoration: InputDecoration(
                fillColor: Color.fromARGB(222, 255, 255, 255),
                filled: true,
                icon: Icon(Icons.person_add, color: Colors.black),
                hintText: "Surname",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .where(
                    "uid",
                    isEqualTo: currentuser.currentUser.uid,
                  )
                  .snapshots(),
              initialData: null,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  return Container(
                    height: 70,
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot mypost =
                              asyncSnapshot.data.docs[index];
                          return Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    if (name.text.isEmpty) {
                                      return null;
                                    } else {
                                      await asyncSnapshot
                                          .data.docs[index].reference
                                          .update({"name": name.text});
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    userProfilepage()));
                                      });
                                    }
                                    if (surname.text.isEmpty) {
                                      return null;
                                    } else {
                                      await asyncSnapshot
                                          .data.docs[index].reference
                                          .update({"surname": surname.text});
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    userProfilepage()));
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  )),
                            ],
                          );
                        })),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ])));
  }
}
