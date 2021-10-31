import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'shared/authentication/loginScreen.dart';
import 'shared/home/mainpage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User? result = FirebaseAuth.instance.currentUser;
    final user = Provider.of<loginModel>(context);

    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds:
            user.uid != null ? const UserMainPage("Welcome..") : LoginScreen(),
        title: const Text(
          'Welcome To LifeStyle App!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 100.0,
        //onClick: () => print("flutter"),
        loaderColor: Colors.blue);
    return Container();
  }
}
