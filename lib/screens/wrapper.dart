import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'shared/authentication/loginScreen.dart';
import 'shared/home/mainpage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User? result = FirebaseAuth.instance.currentUser;
    final user = Provider.of<loginModel>(context);

    print("USER FORM SPLASH ___ " + user.toString());
    return SplashScreenView(
      duration: 3000,
      text: 'Welcome To LifeStyle App!',
      textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      navigateRoute: navigateRoute(user),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    //  return Container();
  }

  StatefulWidget navigateRoute(loginModel user) =>
      user != null ? const UserMainPage("Welcome..") : LoginScreen();
}
