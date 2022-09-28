import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/logpage.dart';
import 'package:flutter_application_4/services/Auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Loginpage.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: Colors.orange.shade400),
          home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Eror"),
                );
              } else if (snapshot.hasData) {
                return logpage();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
