import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");

  loginModel _loggedInUser(User? user) {
    if (user != null) {
      return loginModel.loginResponse(user.uid, user.email);
    } else {
      return loginModel.error("EMPTY USER");
    }
  }

  Stream<loginModel> get user {
    return firebaseAuth.authStateChanges().map((u) => _loggedInUser(u));
  }

  Future<loginModel?> loginUser(loginModel model) async {
    print("Proccessing from Login Fun:\nEmail:" +
        (model.email ?? 'EMPTY!') +
        "\n" +
        (model.password ?? 'EMPTY!'));
    try {
      var loginResult = await firebaseAuth.signInWithEmailAndPassword(
          email: model.email!, password: model.password!);
      if (loginResult.user != null) {
        print("User ID:" + loginResult.user!.uid.toString());
        return _loggedInUser(loginResult.user);
      }
    } on FirebaseAuthException catch (e) {
      return loginModel.error(e.message.toString());
    }
    return null;
  }

  void registerToFb(String name, String email, String pass, String age) {
    print(name + ' - ' + email + ' - ' + pass + ' - ' + age);
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      dbRef
          .child(result.user!.uid)
          .set({"email": email, "age": age, "name": name}).then((res) {
        print("Added");
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
        );*/
      });
    }).catchError((err) {
      print(err);
      /*  showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });*/
    });
  }
}
