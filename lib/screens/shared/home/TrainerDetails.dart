import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Item.dart';
import 'package:liftstyle/models/vmodel/Subscription.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/widgets/image_swipe.dart';
import 'package:liftstyle/services/cart_services.dart';
import 'package:liftstyle/services/subscriptions.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainerDetails extends StatefulWidget {
  const TrainerDetails({Key? key, required this.Trainer}) : super(key: key);
  final loginModel Trainer;

  @override
  _State createState() => _State();
}

class _State extends State<TrainerDetails> {
  final SnackBar _snackBar = SnackBar(
    content: Text("your request to subscribe sent!"),
  );
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    //CartService cartService = CartService(uid: user.uid!);

    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(0),
              children: [
                ImageSwipe(
                  imageList: [widget.Trainer.img],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    left: 24.0,
                    right: 24.0,
                    bottom: 4.0,
                  ),
                  child: Text(
                    widget.Trainer.FullName.toString(),
                    style: boldHeading,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    "Certified Trainer",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    widget.Trainer.bio.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 350),
                  child: IconButton(
                    icon: const Icon(Icons.call),
                    color: Colors.green,
                    tooltip: 'Contacting Trainer',
                    onPressed: () async {
                      await launch(
                          "https://wa.me/${widget.Trainer.phone!}?text=Hello");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            print("CLICK OF SUBSCRIPTION");
                            await _subscribe(user.uid.toString(),
                                widget.Trainer.uid.toString());
                          },
                          child: Container(
                            height: 65.0,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              top: 60.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Subscribe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Future<void> _subscribe(String customerid, String trainerid) async {
    print("START OF SUBSCRIPTION");
    await SubscriptionServices()
        .subscribe(Subscription(
            customerid: customerid,
            trainerid: trainerid,
            active: false,
            planurl: ''))
        .then((value) => showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                print("DONE OF SUBSCRIPTION");
                return Container(
                  height: 400,
                  color: Colors.white70,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Subscribed!',
                          style: regularDarkText,
                        ),
                        ElevatedButton(
                          child: const Text('close'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                );
              },
            ));
  }
}
