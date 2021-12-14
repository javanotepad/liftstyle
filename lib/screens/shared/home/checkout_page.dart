import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

import '../../payPalPaymentScreen.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  static final String tokenizationKey = 'sandbox_v2gc626t_6qsm2bydh2pzdbv5';
  String? _orderId;
  String? title;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    return Consumer<Cart>(
      builder: (context, cart, child) {
        title =
            (cart.basketItems.length > 0 ? cart.totalPrice.toString() : null);
        return Scaffold(
            body: Stack(children: [
          cart.basketItems.isNotEmpty
              ? ListView.builder(
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
                )
              : Center(child: Text("No Item Found!")),
          if (cart.basketItems.isNotEmpty)
            GestureDetector(
              onTap: () async {
                await checkOutAction(context, cart, user)
                    .whenComplete(() => showOrderDialog(context, cart));
              },
              child: Container(
                height: 78.0,
                margin: EdgeInsets.only(top: 458),
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
            showAddButton: false,
            title: "My Cart " +
                (title == null ? "" : "- Total Cost : " + title! + " R.S"),
            hasBackground: true,
            showCart: false,
          ),
        ]));
      },
    );
  }

  void showOrderDialog(BuildContext context, Cart cart) {
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
                  'Your Order ID: ' + _orderId.toString() + "\nThank you",
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
  }

  Future<String?> checkOutAction(
      BuildContext context, Cart cart, loginModel user) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PaypalPayment(
              cart: cart,
              user: user,
              onFinish: (number) {
                // payment done
                if (number != null) {
                  cart.removeAll();

                  _orderId = number;
                  setState() {
                    _orderId = number;
                    title = null;
                  }

                  print('order id: ' + _orderId!);
                  return number;
                }
              },
            )));

    return _orderId;
  }
}
