import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:provider/provider.dart';

class UserService {
  final String uid;
  UserService({required this.uid});
  final CollectionReference productsCollection =
  FirebaseFirestore.instance.collection("products");
  final CollectionReference cartCollection =
  FirebaseFirestore.instance.collection("cart");
  final CollectionReference userDetails =
  FirebaseFirestore.instance.collection("userProfile");

  loginModel _getUserModel(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => loginModel.loginResponse(
        uid, e.get("email").toString(), e.get("img").toString()))
        .single;
  }

  Future updateUserProfile(loginModel user) async {
    return await this.userDetails.doc(uid).set({
      'age': user.Age,
      'fullName': user.FullName,
      'gender': (user.Gender == true ? 'M' : 'F'),
      'length': user.length,
      'weight': user.wight,
      'img': user.img,
      'bio': user.bio,
      'type': user.type,
      'isAdmin': user.isAdmin,
      'phone': user.phone
    });
  }
}
