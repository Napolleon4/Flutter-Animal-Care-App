import 'package:flutter/material.dart';
import 'package:flutter_application_4/loginpage2.dart';
import 'package:flutter_application_4/logpage.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:google_fonts/google_fonts.dart';

class resetpassword extends StatefulWidget {
  const resetpassword({Key key}) : super(key: key);

  @override
  State<resetpassword> createState() => _resetpasswordState();
}

class _resetpasswordState extends State<resetpassword> {
  final _loginformkey = GlobalKey<FormState>();
  Auth _auth = Auth();
  TextEditingController _emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _loginformkey,
          child: Column(
            children: [
              Image.asset(
                "images/photo1.gif",
                height: 250,
              ),
              Text(
                "Did You Forget Your Password?",
                style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your email";
                    } else if (value.isEmpty) {
                      return "Please enter your email";
                    } else {
                      return null;
                    }
                  },
                  controller: _emailcontroller,
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
              ElevatedButton(
                  onPressed: () async {
                    if (_loginformkey.currentState.validate()) {
                      await _auth.resetPassword(_emailcontroller.text);
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginpage2()));
                      });
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Loginpage2()));
                    });
                  },
                  child: Text("goooo")),
            ],
          ),
        ),
      ),
    );
  }
}
