import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/admin/addNewProduct.dart';
import 'package:liftstyle/screens/admin/addNewTrainer.dart';
import 'package:liftstyle/screens/shared/home/checkout_page.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

class CustomActionBar extends StatelessWidget {
  CustomActionBar(
      {Key? key,
      this.title,
      this.hasBackArrrow,
      this.hasTitle,
      this.showAddButton,
      this.showCart,
      this.hasBackground})
      : super(key: key);
  final String? title;
  final bool? hasBackArrrow;
  final bool? hasTitle;
  final bool? hasBackground;
  final bool? showCart;
  final bool? showAddButton;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    final users = Provider.of<List<loginModel>>(context);
    // final current = Provider.of<loginModel>(context);

    print("USERS == " + users.length.toString());

    var user_ = users!.where((element) => element.uid == user.uid).first;
    if (user_.isAdmin == true) {
      print("Current USER IS Admin");
    }
    bool _hasBackArrow = hasBackArrrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Consumer<Cart>(builder: (context, cart, child) {
      return Container(
        decoration: BoxDecoration(
            gradient: _hasBackground
                ? LinearGradient(
                    colors: [
                      Colors.black12,
                      Colors.white.withOpacity(0),
                    ],
                    begin: Alignment(0, 0),
                    end: Alignment(0, 1),
                  )
                : null),
        padding: EdgeInsets.only(
          top: 56.0,
          left: 24.0,
          right: 24.0,
          bottom: 42.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_hasBackArrow)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            if (_hasTitle)
              Text(
                title ?? "Action Bar",
                style: boldHeading,
              ),
            if (user_.isAdmin! && showAddButton! == true)
              GestureDetector(
                onTap: () => (title == "Trainers"
                    ? moveToAddNewTrainer(context)
                    : moveToAddNewProduct(context)),
                child: Container(
                  width: 192.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (title == "Trainers"
                        ? "+ add a Trainer"
                        : "+ add a Product"),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (showCart! == true)
              GestureDetector(
                onTap: () => moveToCart(context),
                child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: (cart.basketItems.length > 0
                        ? Colors.red
                        : Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cart.basketItems.length.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  void moveToCart(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CheckoutPage()));

  void moveToAddNewTrainer(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => AddNewTrainer()));

  moveToAddNewProduct(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => AddNewProduct()));
}
