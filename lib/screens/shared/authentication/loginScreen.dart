import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/shared/authentication/signupScreen.dart';
import 'package:liftstyle/screens/shared/home/mainpage.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/utilities/constants.dart';

import 'forgettenPassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _email = TextEditingController();

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

  Widget _buildPasswordTF(TextEditingController _controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
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
            validator: (val) {
              if (val!.isEmpty) return 'Empty';
              return null;
            },
            obscureText: true,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPassword()),
        ),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          loginPressed();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.deepPurpleAccent,
        child: Text(
          'LOGIN',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen(title: 'Sign Up')),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _form,
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(),
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: AssetImage('assets/images/img.png')),
                          Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          _buildEmailTF(this._email),
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildPasswordTF(this._pass),
                          _buildForgotPasswordBtn(),
                          // _buildRememberMeCheckbox(),
                          _buildLoginBtn(),
                          //  _buildSignInWithText(),
                          //  _buildSocialBtnRow(),
                          _buildSignupBtn(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  loginPressed() async {
    if (this._form.currentState!.validate()) {
      print("Proccessing" +
          "\nEmail:" +
          this._email.text.toString().trim() +
          "\n" +
          this._pass.text.toString().trim());

      var item = await _auth.loginUser(loginModel.loginRequest(
        this._email.text.toString().trim(),
        this._pass.text.toString().trim(),
      ));
      if (item != null) {
        if (item.msg != null) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                  title: Text(' Ops! Login Failed'),
                  content: Text('${item.msg}')));
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserMainPage("Home")),
        );
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Text(' Ops! Login Failed'),
                content: Text('User credentials not correct!')));
      }

      // print("email : " + item.email! + " -- psd : " + item.password!);
    } else {
      print("Not Valid");
    }
  }
}
