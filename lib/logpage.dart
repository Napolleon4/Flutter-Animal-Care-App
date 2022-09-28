import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/resetpassword.dart';

import 'package:flutter_application_4/services/Auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'homapage.dart';
import 'Signinpage.dart';

class logpage extends StatefulWidget {
  const logpage({Key key}) : super(key: key);

  @override
  State<logpage> createState() => _logpageState();
}

class _logpageState extends State<logpage> {
  @override
  Widget build(BuildContext context) {
    final _loginformkey = GlobalKey<FormState>();

    TextEditingController _emailcontroller = TextEditingController();
    TextEditingController _passwordcontroller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => resetpassword()));
              });
            },
            icon: Icon(Icons.help),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Form(
              key: _loginformkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/cat.gif",
                      height: 200,
                      width: 200,
                    ),
                    Text(
                      "Login",
                      style: GoogleFonts.pacifico(
                        fontSize: 45,
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.cat,
                          size: 30,
                        ),
                        TextButton(
                            onPressed: () async {
                              if (_loginformkey.currentState.validate()) {
                                final user = await Provider.of<Auth>(context,
                                        listen: false)
                                    .signinUserwithEmailPassword(
                                        _emailcontroller.text,
                                        _passwordcontroller.text);
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => frontpage()));
                                });
                              }
                            },
                            child: Text(
                              "Meow!",
                              style: GoogleFonts.pacifico(
                                  color: Colors.black, fontSize: 30),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.cat,
                          size: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signinpage()));
                            },
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.pacifico(
                                  color: Colors.black, fontSize: 30),
                            )),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}
