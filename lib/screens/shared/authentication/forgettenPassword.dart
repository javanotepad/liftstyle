import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/screens/shared/home/mainpage.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/utilities/constants.dart';

class ForgotPassword extends StatelessWidget {
  static String id = 'forgot-password';
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _form,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/img.png')),
                  _buildEmailTF(this._email),
                  SizedBox(height: 20),
                  _buildForgetPswBtn(context),
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

  Widget _buildForgetPswBtn(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          loginPressed(ctx);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.deepPurpleAccent,
        child: Text(
          'send rest link to my email',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTF(TextEditingController _controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            controller: _controller,
            validator: (val) => EmailValidator.validate(val!)
                ? null
                : "Please Enter Valid Email!",
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  loginPressed(BuildContext ctx) async {
    if (this._form.currentState!.validate()) {
      var item = await _auth.RestPassword(_email.text.toString()).then(
          (value) => showDialog(
              context: ctx,
              builder: (ctx) => AlertDialog(
                  title: Text('Alert'), content: Text('Email has been sent'))));
    }
  }
}
