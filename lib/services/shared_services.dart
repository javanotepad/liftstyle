import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';

class SharedServices {
  final CollectionReference userDetails =
      FirebaseFirestore.instance.collection("userProfile");
  static Future uploadUserImage(String dest, File image) async {
    try {
      final item = await FirebaseStorage.instance
          .ref(dest)
          .putFile(image)
          .whenComplete(() => {});
      final url = await item.ref.getDownloadURL();
      print("URL " + url);
      return url;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  List<loginModel> _usersList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final user_ = loginModel();
      user_.uid = doc.id.toString();
      user_.img = doc.get("img").toString();
      user_.length = int.parse(doc.get("length").toString());
      user_.wight = int.parse(doc.get("weight").toString());
      user_.Age = int.parse(doc.get("age").toString());
      user_.FullName = doc.get("fullName").toString();
      user_.bio = doc.get("bio").toString();
      user_.type = doc.get("type").toString();
      user_.isAdmin = doc.get("isAdmin");
      user_.phone = doc.get("phone");

      return user_;
    }).toList();
  }

  Future<loginModel> getUserById(String uid) async {
    loginModel model = loginModel();
    await this.userDetails.doc(uid).get().then((value) => () {
          model.uid = value.id.toString();
          model.img = value.get("img").toString();
          model.length = int.parse(value.get("length").toString());
          model.wight = int.parse(value.get("weight").toString());
          model.Age = int.parse(value.get("age").toString());
          model.FullName = value.get("fullName").toString();
          model.bio = value.get("bio").toString();
          model.type = value.get("type").toString();
          model.isAdmin = value.get("isAdmin");
          model.phone = value.get("phone");
        });
    return model;
  }

  /* Future<loginModel> checkIsAdmin(String uid) async {
    loginModel model = loginModel();
    print("RECIVED USER ID =$uid");
    userDetails.
          model.uid = event.id.toString();
          model.img = event.get("img").toString();
          model.length = int.parse(event.get("length").toString());
          model.wight = int.parse(event.get("weight").toString());
          model.Age = int.parse(event.get("age").toString());
          model.FullName = event.get("fullName").toString();
          model.bio = event.get("bio").toString();
          model.type = event.get("type").toString();
          model.isAdmin = event.get("isAdmin");

          return model;
        });

    print("ITEM UPDATED: " +
        model.isAdmin.toString() +
        "TYPE: " +
        model.type.toString());
    return model;
  }*/

  Stream<List<loginModel>> get users {
    final items = userDetails.snapshots();

    return items.map((event) => _usersList(event));
  }
}
