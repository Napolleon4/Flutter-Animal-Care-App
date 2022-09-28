import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Whoof.dart';
import 'package:flutter_application_4/logpage.dart';
import 'package:flutter_application_4/model/user.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:flutter_application_4/services/Howtouse.dart';
import 'package:flutter_application_4/services/Status_service.dart';
import 'package:flutter_application_4/userProfilepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_container/tab_container.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:flutter_application_4/services/person_service.dart';

class homepage extends StatefulWidget {
  const homepage({Key key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Statusservice _statusservice = Statusservice();
  Userservice _userservice = Userservice();
  Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 100.0, top: 8),
            child: Container(
              child: Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Dog",
                      hintStyle: GoogleFonts.pacifico(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 10,
              width: 200,
            ),
          )
        ],
      ),
      drawer: Drawer(
          backgroundColor: Colors.orangeAccent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  child: Image.asset(
                "images/walkingdog.gif",
              )),
              ListTile(
                leading: Icon(Icons.people),
                iconColor: Colors.black,
                title: Text(
                  "Profile Page",
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => userProfilepage())));
                },
              ),
              ListTile(
                leading: Icon(Icons.question_mark),
                iconColor: Colors.black,
                title: Text(
                  "How to use",
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Howtouse())));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_outlined),
                iconColor: Colors.black,
                title: Text(
                  "Log out",
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold, fontSize: 19),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  print("logout");
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => logpage()));
                  });
                },
              )
            ],
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: _statusservice.getStatus(),
        initialData: null,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                    padding: EdgeInsets.all(8.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: asyncSnapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mypost = asyncSnapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: StreamBuilder<Object>(
                            stream: slimyCard.stream,
                            builder: (context, AsyncSnapshot snapshot) {
                              return SlimyCard(
                                topCardHeight: 370,
                                bottomCardHeight: 300,
                                color: Colors.greenAccent,
                                topCardWidget: ListView(children: [
                                  CircleAvatar(
                                    radius: 45,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(mypost["name"],
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(mypost["surname"],
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.pets),
                                      Text("Pet:",
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      Text(mypost["Type"],
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.dollarSign),
                                      Text("Price:",
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      Text(mypost["Price"],
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.locationArrow),
                                      Text("Location:",
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      Text(mypost["Location"],
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.date_range),
                                      Text(mypost["Date"],
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23)),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(mypost["lastdate"],
                                          style: GoogleFonts.pacifico(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23)),
                                    ],
                                  ),
                                ]),
                                bottomCardWidget: ListView(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "About Me ",
                                        style: GoogleFonts.pacifico(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                      flex: 2,
                                      child: Text(
                                        mypost["Aboutme"],
                                        style: GoogleFonts.pacifico(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.message)),
                                ]),
                              );
                            }),
                      );
                    }));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class topcontainerall extends StatelessWidget {
  String Pet;
  String Price;
  String Location;
  String Date;
  String lastdate;
  topcontainerall({
    Key key,
    this.Pet,
    this.Price,
    this.Location,
    this.Date,
    this.lastdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          CircleAvatar(
            radius: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("name",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(
                width: 3,
              ),
              Text("surname",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 25)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.pets),
              Text(Pet,
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 25))
            ],
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.dollarSign),
              Text(Price,
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 25))
            ],
          ),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.locationArrow),
              Text(Location,
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 25)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.date_range),
              Text(Date,
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 23)),
              SizedBox(
                width: 4,
              ),
              Text(lastdate,
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 23)),
            ],
          ),
        ],
      )),
    );
  }
}

class bottomcontainerall extends StatelessWidget {
  String aboutme;
  bottomcontainerall({Key key, this.aboutme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "About Me ",
            style:
                GoogleFonts.pacifico(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Flexible(
              flex: 2,
              child: Row(
                children: [
                  Text(
                    aboutme,
                    style: GoogleFonts.pacifico(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ))
        ],
      )),
    );
  }
}
