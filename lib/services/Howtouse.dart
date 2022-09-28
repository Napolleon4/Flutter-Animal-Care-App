import 'package:flutter/material.dart';
import 'package:flutter_application_4/Homepage.dart';
import 'package:flutter_application_4/Whoof.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Howtouse extends StatefulWidget {
  const Howtouse({Key key}) : super(key: key);

  @override
  State<Howtouse> createState() => _HowtouseState();
}

class _HowtouseState extends State<Howtouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
    );
  }
}
