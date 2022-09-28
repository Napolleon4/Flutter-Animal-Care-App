import 'package:flutter/material.dart';
import 'package:flutter_application_4/Homepage.dart';
import 'package:flutter_application_4/Whoof.dart';
import 'package:flutter_application_4/chat.dart';
import 'package:flutter_application_4/profilepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class frontpage extends StatefulWidget {
  const frontpage({Key key}) : super(key: key);

  @override
  State<frontpage> createState() => _frontpageState();
}

class _frontpageState extends State<frontpage> {
  final screes = [
    homepage(),
    chat(),
    Whoof(),
  ];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screes[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentindex,
          onTap: (index) => setState(() => currentindex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Message",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.dog),
              label: "Whoof!",
            ),
          ]),
    );
  }
}
