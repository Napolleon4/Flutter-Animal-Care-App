import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Signinpage.dart';
import 'logpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/photo1.gif"),
          Text(
            "Welcome",
            style: GoogleFonts.pacifico(
              fontSize: 55,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pets,
                size: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signinpage()));
                  },
                  child: Text(
                    "Sign in",
                    style:
                        GoogleFonts.pacifico(color: Colors.black, fontSize: 30),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pets,
                size: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => logpage()));
                  },
                  child: Text(
                    "Login",
                    style:
                        GoogleFonts.pacifico(color: Colors.black, fontSize: 30),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
