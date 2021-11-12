import 'package:flutter/material.dart';

final logoutTxt = Text("Logout",
    style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'));

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);
final radioTextStyle = new TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);
final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
enum Gender { Male, Female }
final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final regularDarkText =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);
const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');
const IconData bookmark = IconData(0xe0f1, fontFamily: 'MaterialIcons');
const IconData search = IconData(0xf4a5, fontFamily: 'MaterialIcons');
const IconData home = IconData(0xe318, fontFamily: 'MaterialIcons');
