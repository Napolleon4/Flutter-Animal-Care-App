import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/homapage.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class usersChangepage extends StatefulWidget {
  String password;
  usersChangepage({Key key, this.password}) : super(key: key);

  @override
  State<usersChangepage> createState() => _usersChangepageState();
}

class _usersChangepageState extends State<usersChangepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/dog1.gif"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
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
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Welcome Back!",
                          style: GoogleFonts.pacifico(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 500,
                        height: 500,
                        child: ListView.builder(
                            itemCount: asyncSnapshot.data.docs.length,
                            itemBuilder: ((context, index) {
                              DocumentSnapshot mypost =
                                  asyncSnapshot.data.docs[index];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        mypost["name"],
                                        style: GoogleFonts.pacifico(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        mypost["surname"],
                                        style: GoogleFonts.pacifico(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 390.0),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await asyncSnapshot
                                              .data.docs[index].reference
                                              .update({
                                            "password": widget.password
                                          });
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        frontpage()));
                                          });
                                        },
                                        child: Text(
                                          "Lets Start!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              );
                            })),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
