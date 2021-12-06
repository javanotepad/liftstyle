import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

import '../../payPalPaymentScreen.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _orderId;
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
            body: cart.basketItems.length == 0
                ? Text('no items in your cart')
                : Stack(children: [
                    ListView.builder(
                      itemCount: cart.basketItems.length,
                      padding: EdgeInsets.only(
                        top: 108.0,
                        bottom: 12.0,
                      ),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              cart.basketItems[index].productimageurl,
                              fit: BoxFit.cover,
                            ),
                            title: Text(cart.basketItems[index].title),
                            subtitle:
                                Text(cart.basketItems[index].price.toString()),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                cart.remove(cart.basketItems[index]);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _checkOutAction(context);
                        showOrderDialog("_orderId", context, cart);
                      },
                      child: Container(
                        height: 78.0,
                        margin: EdgeInsets.only(top: 758),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    CustomActionBar(
                      hasTitle: true,
                      title: "My Cart - Total Cost : " +
                          cart.totalPrice.toString() +
                          " R.S",
                      hasBackground: true,
                      showCart: false,
                    ),
                  ]));
      },
    );
  }

  void showOrderDialog(String IdNumber, BuildContext context, Cart cart) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Colors.white70,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Your Order ID: ' + IdNumber + "\nThank you",
                  style: regularDarkText,
                ),
                ElevatedButton(
                  child: const Text('Continue shoping'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
    cart.removeAll();
  }

  Future _checkOutAction(BuildContext context) async {
    String id = "";
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaypalPayment(
              onFinish: (number) {
                // payment done
                if (number != null) {
                  id = number;

                  print('order id: ' + id);

                  return number;
                }
              },
            )));
    print("ORDER ID_ " + id);
  }
}