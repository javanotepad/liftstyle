import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/screens/widgets/productCard.dart';
import 'package:liftstyle/screens/widgets/trainerCard.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

import 'TrainerDetails.dart';

class TrainersPage extends StatefulWidget {
  const TrainersPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<TrainersPage> {
  @override
  Widget build(BuildContext context) {
    final uu = Provider.of<List<loginModel>>(context);
    print("USERS : " + uu.length.toString());
    return Consumer<List<loginModel>>(builder: (context, users, child) {
      return Scaffold(
          body: Stack(children: [
        ListView(
          padding: EdgeInsets.only(
            top: 108.0,
            bottom: 12.0,
          ),
          children: users
              .where((element) => element.type == 'Trainer')
              .map((e) => TrainerCard(
                    item: checkImage(e),
                  ))
              .toList(),
        ),
        CustomActionBar(
          hasBackArrrow: false,
          showAddButton: true,
          title: "Trainers",
          hasBackground: false,
          showCart: true,
        ),
      ]));
    });
  }

  loginModel checkImage(loginModel e) {
    print("IMAGE IS " + e.img.toString());
    e.img ??= trainer_img_df;
    if (e.img == 'null') {
      print("image is null!!!");
      e.img = trainer_img_df;
    }
    return e;
  }
}
