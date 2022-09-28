import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_4/model/Status.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:flutter_application_4/services/Status_service.dart';
import 'package:flutter_application_4/services/calculate.dart';
import 'package:flutter_application_4/services/person_service.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

class Whoof extends StatefulWidget {
  const Whoof({
    Key key,
  }) : super(key: key);

  @override
  State<Whoof> createState() => _WhoofState();
}

class _WhoofState extends State<Whoof> {
  TextEditingController Pet = TextEditingController();
  TextEditingController Price = TextEditingController();
  TextEditingController Location = TextEditingController();
  TextEditingController Aboutme = TextEditingController();
  TextEditingController firstdate = TextEditingController();
  TextEditingController lastdate = TextEditingController();

  Statusservice _statusservice = Statusservice();
  Userservice _userservice = Userservice();
  Auth auth = Auth();
  final _formkeyy = GlobalKey<FormState>();

  void dispose() {
    firstdate.dispose();
    lastdate.dispose();

    Pet.dispose();
    Price.dispose();
    Location.dispose();
    Aboutme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Formalani(
                formkeyy: _formkeyy,
                Pet: Pet,
                Price: Price,
                Location: Location,
                firstdate: firstdate,
                lastdate: lastdate,
                Aboutme: Aboutme,
                statusservice: _statusservice,
                userservice: _userservice)),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Status")
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
                      decoration: BoxDecoration(),
                      width: 3000,
                      height: 766,
                      child: ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: asyncSnapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot mypost =
                                asyncSnapshot.data.docs[index];
                            return StreamBuilder<Object>(
                                stream: slimyCard.stream,
                                initialData: null,
                                builder: (context, AsyncSnapshot snapshot) {
                                  return Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: SlimyCard(
                                        topCardHeight: 370,
                                        bottomCardHeight: 300,
                                        color: Colors.greenAccent,
                                        topCardWidget: ListView(children: [
                                          CircleAvatar(
                                            radius: 45,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(mypost["name"],
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(mypost["surname"],
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.pets),
                                              Text("Pet:",
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                              Text(mypost["Type"],
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              FaIcon(
                                                  FontAwesomeIcons.dollarSign),
                                              Text("Price:",
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                              Text(mypost["Price"],
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons
                                                  .locationArrow),
                                              Text("Location:",
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                              Text(mypost["Location"],
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.date_range),
                                              Text(mypost["Date"],
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23)),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(mypost["lastdate"],
                                                  style: GoogleFonts.pacifico(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23)),
                                            ],
                                          ),
                                        ]),
                                        bottomCardWidget: ListView(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "About Me ",
                                                style: GoogleFonts.pacifico(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                              flex: 2,
                                              child: Text(
                                                mypost["Aboutme"],
                                                style: GoogleFonts.pacifico(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                DocumentSnapshot snapshot =
                                                    asyncSnapshot
                                                        .data.docs[index];
                                                _statusservice
                                                    .deleteStatus(snapshot.id);
                                              },
                                              icon: FaIcon(
                                                  FontAwesomeIcons.trash)),
                                        ]),
                                      ));
                                });
                          }));
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Formalani extends StatelessWidget {
  Formalani({
    Key key,
    @required GlobalKey<FormState> formkeyy,
    @required this.Pet,
    @required this.Price,
    @required this.Location,
    @required this.firstdate,
    @required this.lastdate,
    @required this.Aboutme,
    @required Statusservice statusservice,
    @required Userservice userservice,
  })  : _formkeyy = formkeyy,
        _statusservice = statusservice,
        _userservice = userservice,
        super(key: key);

  final currentuser = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkeyy;
  final TextEditingController Pet;
  final TextEditingController Price;
  final TextEditingController Location;
  final TextEditingController firstdate;
  final TextEditingController lastdate;
  final TextEditingController Aboutme;
  final Statusservice _statusservice;
  final Userservice _userservice;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkeyy,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the pet!";
                } else {
                  return null;
                }
              },
              controller: Pet,
              decoration: InputDecoration(
                  icon: Icon(Icons.pets, color: Colors.black),
                  hintText: "Pet",
                  hintStyle: GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the pet!";
                } else {
                  return null;
                }
              },
              controller: Price,
              decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle: GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                  icon: Icon(Icons.attach_money, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the location!";
                } else {
                  return null;
                }
              },
              controller: Location,
              decoration: InputDecoration(
                  hintText: "Location",
                  hintStyle: GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                  icon: Icon(Icons.location_history, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: firstdate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the last date!";
                } else {
                  return null;
                }
              },
              onTap: () async {
                var _selecteddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2050));
                firstdate.text = Calculator.datetimetoString(_selecteddate);
              },
              decoration: InputDecoration(
                  hintText: "First Date",
                  hintStyle: GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                  icon: Icon(Icons.date_range, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: lastdate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the last date!";
                } else {
                  return null;
                }
              },
              onTap: () async {
                var _selectedlastdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2050));
                lastdate.text = Calculator.datetimetoString(_selectedlastdate);
              },
              decoration: InputDecoration(
                  hintText: "Last Date",
                  hintStyle: GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                  icon: Icon(Icons.date_range, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Text(
                    "About Me",
                    style: GoogleFonts.pacifico(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please write something  About your self!";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Hi my name is Bogac!",
                      hintStyle:
                          GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                    ),
                    controller: Aboutme,
                  ),
                ),
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                initialData: null,
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where(
                      "uid",
                      isEqualTo: currentuser.currentUser.uid,
                    )
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 25, top: 8),
                      child: Container(
                        height: 50,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            DocumentSnapshot usr = snapshot.data.docs[index];
                            return ElevatedButton(
                                onPressed: () {
                                  if (_formkeyy.currentState.validate()) {}
                                  ;

                                  _statusservice.addStatus(
                                    DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString(),
                                    usr["name"].toString(),
                                    usr["surname"].toString(),
                                    currentuser.currentUser.uid,
                                    firstdate.text,
                                    Location.text,
                                    Price.text,
                                    Pet.text,
                                    lastdate.text,
                                    Aboutme.text,
                                  );
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ));
                          },
                        ),
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ));
  }
}
