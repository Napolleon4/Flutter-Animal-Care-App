import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Whoof.dart';
import 'package:flutter_application_4/deneme.dart';
import 'package:flutter_application_4/logpage.dart';
import 'package:flutter_application_4/services/person_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class profilepage extends StatefulWidget {
  String email;
  String password1;
  String password2;
  profilepage({Key key, this.email, this.password1, this.password2})
      : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

TextEditingController name = TextEditingController();
TextEditingController surname = TextEditingController();
final currentuser = FirebaseAuth.instance;
void dispose() {
  name.dispose();
  surname.dispose();
}

Userservice _userservice = Userservice();

class _profilepageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 70,
              ),
              CircleAvatar(
                child: IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    size: 30,
                  ),
                ),
                radius: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_add, color: Colors.black),
                      hintText: "Name",
                      hintStyle:
                          GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: surname,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_add, color: Colors.black),
                      hintText: "Surname",
                      hintStyle:
                          GoogleFonts.pacifico(fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _userservice.addUser(
                      currentuser.currentUser.uid,
                      name.text,
                      surname.text,
                      widget.email,
                      widget.password1,
                    );

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => logpage()));
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ]),
          ),
        ));
  }
}
