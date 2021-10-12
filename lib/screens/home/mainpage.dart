import 'package:flutter/material.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage(String title, {Key? key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("User Area"),
    );
  }
}
