import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/screens/shared/home/mainpage.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:liftstyle/utilities/constants.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/img.png')),
                  SizedBox(height: 20),
                  Text(
                    aboutUs,
                    style: TextStyle(fontSize: 21),
                  ),
                  /*   RaisedButton(
                    child: Text('Send Email'),
                    onPressed: () {},
                  )*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
