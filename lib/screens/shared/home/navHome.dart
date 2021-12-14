import 'package:flutter/material.dart';
import 'package:liftstyle/screens/shared/authentication/loginScreen.dart';
import 'package:liftstyle/screens/shared/home/userProfile.dart';
import 'package:liftstyle/services/auth_service.dart';

import 'aboutUs.dart';

class NavDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    image: AssetImage('assets/images/img.png'))),
            child: null,
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                  ))
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('About Us'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await this._authService.signOut().whenComplete(() => moveToLogin);
            },
          ),
        ],
      ),
    );
  }

  void moveToLogin(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => LoginScreen()));
}
