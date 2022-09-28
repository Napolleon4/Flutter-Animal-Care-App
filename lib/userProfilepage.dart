import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:flutter_application_4/profilepageSettings.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:google_fonts/google_fonts.dart';

class userProfilepage extends StatefulWidget {
  const userProfilepage({Key key}) : super(key: key);

  @override
  State<userProfilepage> createState() => _userProfilepageState();
}

class _userProfilepageState extends State<userProfilepage> {
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => profilePage_Settings()));
                  });
                },
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder<QuerySnapshot>(
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
                  width: 500,
                  height: 500,
                  child: ListView.builder(
                      itemCount: asyncSnapshot.data.docs.length,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot mypost =
                            asyncSnapshot.data.docs[index];
                        return SizedBox(
                          height: 500,
                          child: ListView(
                            children: [
                              CircleAvatar(
                                radius: 50,
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.person),
                                title: Text(
                                  mypost["name"],
                                  style: GoogleFonts.pacifico(),
                                ),
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.person),
                                title: Text(
                                  mypost["surname"],
                                  style: GoogleFonts.pacifico(),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.mail),
                                title: Text(
                                  mypost["email"],
                                  style: GoogleFonts.pacifico(),
                                ),
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.lock),
                                title: Text(mypost["password"]),
                              ),
                            ],
                          ),
                        );
                      })),
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
