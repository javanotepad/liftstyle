import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Item.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/widgets/image_swipe.dart';
import 'package:liftstyle/services/cart_services.dart';
import 'package:liftstyle/services/productServices.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

import 'mainpage.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.Product}) : super(key: key);
  final product Product;

  @override
  _State createState() => _State();
}

class _State extends State<ProductDetails> {
  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart"),
  );
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    //CartService cartService = CartService(uid: user.uid!);

    final users = Provider.of<List<loginModel>>(context);

    var user_ = users.where((element) => element.uid == user.uid).first;
    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(0),
              children: [
                ImageSwipe(
                  imageList: [widget.Product.prdimgurl],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    left: 24.0,
                    right: 24.0,
                    bottom: 4.0,
                  ),
                  child: Text(
                    widget.Product.prdname.toString(),
                    style: boldHeading,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    widget.Product.prdprice.toString() + "  SR",
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
                    widget.Product.prddetails.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (user_.isAdmin! == true)
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await showAlertDialog(context);
                            },
                            child: Container(
                              height: 65.0,
                              margin: EdgeInsets.only(),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Detele this Item",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            cart.add(Item(
                                price: widget.Product.prdprice!,
                                title: widget.Product.prdname!,
                                productimageurl: widget.Product.prdimgurl!,
                                desception: widget.Product.prddetails!));
                            /*   await cartService.updateUserCart(Cart(
                              user.uid, widget.Product.prdId, widget.Product));*/
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 400,
                                  color: Colors.white70,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Item added to your Cart!',
                                          style: regularDarkText,
                                        ),
                                        ElevatedButton(
                                          child: const Text('Continue shoping'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 65.0,
                            margin: EdgeInsets.only(),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes go ahead"),
      onPressed: () async {
        ProductServices().deleteProduct(widget.Product.prdId!).whenComplete(
            () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserMainPage("HOME"))));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert .."),
      content: Text("Would you like to continue delete this item?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
