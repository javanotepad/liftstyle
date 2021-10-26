import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/authentication/loginScreen.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

import 'navHome.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage(String title, {Key? key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    if (user.uid == null) {
      return LoginScreen();
    } else {
      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Side menu'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(Icons.person),
              label: logoutTxt,
            )
          ],
        ),
        body: Center(
          child: Text('Side Menu Tutorial'),
        ),
      );
    }
  }
}
