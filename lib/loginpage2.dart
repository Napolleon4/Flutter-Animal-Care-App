import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/homapage.dart';
import 'package:flutter_application_4/model/user.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:flutter_application_4/services/person_service.dart';
import 'package:flutter_application_4/usersChangepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Loginpage2 extends StatefulWidget {
  const Loginpage2({Key key}) : super(key: key);

  @override
  State<Loginpage2> createState() => _Loginpage2State();
}

class _Loginpage2State extends State<Loginpage2> {
  @override
  Widget build(BuildContext context) {
    final _loginformkey = GlobalKey<FormState>();
    Userservice _userService = Userservice();

    TextEditingController _emailcontroller = TextEditingController();
    TextEditingController _passwordcontroller = TextEditingController();
    return Scaffold(
      body: Form(
          key: _loginformkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/photo1.gif",
                  height: 250,
                ),
                Text(
                  "Login with your new password",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailcontroller,
                    validator: (value) {
                      if (!EmailValidator.validate(value)) {
                        return "Please enter the e-mail";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(222, 255, 255, 255),
                        filled: true,
                        prefixIcon: Icon(Icons.email),
                        hintText: "E-mail",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordcontroller,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter the password";
                      } else if (value.isEmpty) {
                        return "Please enter the password";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(222, 255, 255, 255),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_loginformkey.currentState.validate()) {
                        final user =
                            await Provider.of<Auth>(context, listen: false)
                                .signinUserwithEmailPassword(
                                    _emailcontroller.text,
                                    _passwordcontroller.text);
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => usersChangepage(
                                        password: _passwordcontroller.text,
                                      )));
                        });
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )),
    );
  }
}
