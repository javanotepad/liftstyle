import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/services/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  loginModel _loggedInUser(User? user) {
    if (user != null) {
      return loginModel.loginResponse(user.uid, user.email);
    } else {
      return loginModel.error("EMPTY USER");
    }
  }

  // check the user if it is still logged in
  Stream<loginModel> get user {
    return firebaseAuth.authStateChanges().map((u) => _loggedInUser(u));
  }

  //login user
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

  Future signOut() async {
    try {
      return await this.firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  //register a new users
  void registerToFb(String name, String email, String pass, String age) {
    print(name + ' - ' + email + ' - ' + pass + ' - ' + age);
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((result) async {
      var user = _loggedInUser(result.user);
      user.Gender = true;
      user.Age = int.parse(age);
      user.FullName = name;
      await DatabaseService(uid: result.user!.uid).updateUserProfile(user);
      print("Added");
    }).catchError((err) {
      print(err);
    });
  }
}
