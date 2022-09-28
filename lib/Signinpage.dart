import 'package:flutter/material.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import 'logpage.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key key}) : super(key: key);

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  @override
  Widget build(BuildContext context) {
    final _signinformkey = GlobalKey<FormState>();
    TextEditingController _emailcontroller = TextEditingController();
    TextEditingController _passwordcontroller = TextEditingController();
    TextEditingController _passwordconfirmcontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
          key: _signinformkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "images/cat.gif",
                  height: 200,
                  width: 200,
                ),
                Text(
                  "Sign in",
                  style: GoogleFonts.pacifico(
                    fontSize: 45,
                  ),
                ),
                SizedBox(
                  height: 20,
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
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(222, 255, 255, 255),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordconfirmcontroller,
                    validator: (value) {
                      if (_passwordcontroller.text !=
                          _passwordconfirmcontroller.text) {
                        return "Passwords must be same";
                      } else if (value.isEmpty) {
                        return "Please enter the password";
                      } else {
                        if (value == null) {
                          return "Please enter the password";
                        } else {
                          return null;
                        }
                      }
                      ;
                    },
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
                    TextButton(
                        onPressed: () async {
                          if (_signinformkey.currentState.validate()) {
                            final user =
                                await Provider.of<Auth>(context, listen: false)
                                    .createUserwithEmailPassword(
                                        _emailcontroller.text,
                                        _passwordcontroller.text);
                            if (!user.emailVerified) {
                              await user.sendEmailVerification();
                            }
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profilepage(
                                            email: _emailcontroller.text,
                                            password1: _passwordcontroller.text,
                                            password2:
                                                _passwordconfirmcontroller.text,
                                          )));
                            });
                          }
                        },
                        child: Text(
                          "Next",
                          style: GoogleFonts.pacifico(
                              color: Colors.black, fontSize: 23),
                        )),
                    FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 22,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
