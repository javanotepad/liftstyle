import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Subscription.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/screens/widgets/planCard.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({Key? key}) : super(key: key);

  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  File? file;
  String? uid;
  String? fileurl;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    return Consumer<List<Subscription>>(builder: (context, subs, child) {
      print("ITEMS ==== " +
          subs
              .where((element) => element.customerid == user.uid)
              .length
              .toString());
      return Scaffold(
        body: Stack(children: [
          ListView(
            padding: EdgeInsets.only(
              top: 108.0,
              bottom: 12.0,
            ),
            children: subs
                .where((element) => element.customerid == user.uid)
                .map((e) => PlanCard(
                    item: e, index: subs.indexOf(e) + 1, isTrainer: false))
                .toList(),
          ),
          CustomActionBar(
            hasBackArrrow: false,
            showAddButton: true,
            title: "Plans",
            hasBackground: false,
            showCart: true,
          ),
        ]),
      );
    });
  }
}
