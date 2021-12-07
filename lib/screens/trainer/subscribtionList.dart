import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Subscription.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/screens/widgets/planCard.dart';
import 'package:provider/provider.dart';

class SubscribtionList extends StatefulWidget {
  const SubscribtionList({Key? key}) : super(key: key);

  @override
  _SubscribtionListState createState() => _SubscribtionListState();
}

class _SubscribtionListState extends State<SubscribtionList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    final users = Provider.of<List<loginModel>>(context);

    return Consumer<List<Subscription>>(builder: (context, subs, child) {
      print("ITEMS ==== " +
          subs
              .where((element) => element.trainerid == user.uid)
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
                  .where((element) => element.trainerid == user.uid)
                  .map((e) => PlanCard(
                      item: e, index: subs.indexOf(e) + 1, isTrainer: true))
                  .toList()),
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
