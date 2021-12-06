import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Item.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/widgets/cartCard.dart';
import 'package:liftstyle/services/cart_services.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, String? uid}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);

    return Consumer<Cart>(builder: (context, cart, child) {
      return Scaffold(
        body: ListView(
          padding: EdgeInsets.only(
            top: 108.0,
            bottom: 12.0,
          ),
          children: cart.basketItems.map((e) => CartCard(item: e)).toList(),
        ),
      );
    });
  }
}
