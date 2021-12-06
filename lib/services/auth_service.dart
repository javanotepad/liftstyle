import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/services/user_service.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:liftstyle/utilities/constants.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userDetails =
      FirebaseFirestore.instance.collection("userProfile");

  loginModel _loggedInUser(User? user, String? img) {
    if (user != null) {
      return loginModel.loginResponse(user.uid, user.email, img);
    } else {
      return loginModel.error("EMPTY USER");
    }
  }

  // check the user if it is still logged in
  Stream<loginModel> get user {
    return firebaseAuth.authStateChanges().map((u) => _loggedInUser(u, null));
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
        // SharedServices().getUserById(loginResult.user!.uid);
        return _loggedInUser(loginResult.user, null);
        // loginModel adminuser =
        //  await SharedServices().checkIsAdmin(loginResult.user!.uid);

        // print("ADMIN USER : --- " + adminuser.isAdmin.toString());
        //    loginModel user_ = _loggedInUser(loginResult.user);
        // user_.isAdmin = adminuser.isAdmin;
        // return user_;
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
  Future registerToFb(String name, String email, String pass, String age,
      int weight, int length, String? bio, String? img, int type) async {
    print(name + ' - ' + email + ' - ' + pass + ' - ' + age);

    FirebaseApp _app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);

    FirebaseAuth firebaseAuth_ = await FirebaseAuth.instanceFor(app: _app);
    await firebaseAuth_
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((result) async {
      var user = _loggedInUser(result.user, img);
      user.Gender = true;
      user.Age = int.parse(age);
      user.FullName = name;
      user.length = length;
      user.wight = weight;
      user.bio = bio;
      user.type = (type == 1 ? "customer" : Trainer);
      user.isAdmin = false;
      user.img = img;
      // await UserService(uid: result.user!.uid).updateUserProfile(user);
      await updateUserProfile(user);
    });

    await _app.delete();
    return Future.sync(() => firebaseAuth_);
  }

  Future updateUserProfile(loginModel user) async {
    return await this.userDetails.doc(user.uid).set({
      'age': user.Age,
      'fullName': user.FullName,
      'gender': (user.Gender == true ? 'M' : 'F'),
      'length': user.length,
      'weight': user.wight,
      'img': user.img,
      'bio': user.bio,
      'type': user.type,
      'isAdmin': user.isAdmin
    });
  }
}
