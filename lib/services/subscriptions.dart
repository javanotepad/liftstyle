import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Subscription.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';

class SubscriptionServices {
  final CollectionReference subscriptionCollection =
      FirebaseFirestore.instance.collection("subscriptions");

  List<Subscription> _subscriptionList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Subscription(
          customerid: doc.get("customerid").toString(),
          trainerid: doc.get("trainerid").toString(),
          planurl: doc.get("planurl").toString(),
          active: doc.get("active"));
    }).toList();
  }

  Stream<List<Subscription>> get subscriptions {
    return subscriptionCollection.snapshots().map(_subscriptionList);
  }

  Future subscribe(Subscription subscription) async {
    if (!await isPlanAlreadyExist(subscription)) {
      return await this
          .subscriptionCollection
          .doc(subscription.customerid)
          .set({
        'planurl': '',
        'customerid': subscription.customerid,
        'trainerid': subscription.trainerid,
        'active': false
      });
    }
  }

  Future updateSubscription(Subscription subscription) async {
    return await this.subscriptionCollection.doc(subscription.customerid).set({
      'planurl': subscription.planurl,
      'customerid': subscription.customerid,
      'trainerid': subscription.trainerid,
      'active': true
    });
  }

  Future<bool> isPlanAlreadyExist(Subscription subscription) async {
    final QuerySnapshot result = await this
        .subscriptionCollection
        .where('trainerid', isEqualTo: subscription.trainerid.toString())
        .where('customerid', isEqualTo: subscription.customerid.toString())
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    print("LENGTH OF SUBS. :" + result.docs.length.toString());
    return documents.length == 1;
  }
}
