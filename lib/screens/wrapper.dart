import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'authentication/loginScreen.dart';
import 'home/mainpage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;

    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds:
            result != null ? const UserMainPage("Welcome..") : LoginScreen(),
        title: const Text(
          'Welcome To Meet up!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.red);
    return Container();
  }
}
