import 'package:flutter/material.dart';

final String aboutUs =
    "The ls application helps you to reach your goal of losing"
    " weight or enjoying a healthy and ideal body through sports experts and "
    "providing healthy foods and sports tools that suit you during the period of"
    " progressing to your goal Ls aims to reach the largest segment of society "
    "and help them reach their goals";
final String prd_tmp =
    'https://firebasestorage.googleapis.com/v0/b/lifestyle-fcae0.appspot.com/o/tmp_prd.jpg?alt=media&token=13392d56-ca6b-48de-99c5-8d2685e9971f';
final String trainer_img_df =
    'https://firebasestorage.googleapis.com/v0/b/lifestyle-fcae0.appspot.com/o/istockphoto-1072395722-612x612.jpg?alt=media&token=f8cbefb8-bb9c-459c-a807-964aa5e5464d';
final String Trainer = "Trainer";
final logoutTxt = Text("Logout",
    style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'));

final kHintTextStyle = TextStyle(
  color: Colors.deepPurple,
  fontFamily: 'OpenSans',
);
final radioTextStyle = new TextStyle(
  color: Colors.indigo,
  fontFamily: 'OpenSans',
);
final kLabelStyle = TextStyle(
  color: Colors.deepPurple,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
enum Gender { Male, Female }
final kBoxDecorationStyle =
    BoxDecoration(border: Border.all(color: Colors.deepPurpleAccent, width: 1));

/*BoxDecoration(
  color: Colors.white60,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);*/

final regularDarkText =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);
const regularHeading =
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);
const boldHeading =
    TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');
const IconData bookmark = IconData(0xe0f1, fontFamily: 'MaterialIcons');
const IconData search = IconData(0xf4a5, fontFamily: 'MaterialIcons');
const IconData home = IconData(0xe318, fontFamily: 'MaterialIcons');
