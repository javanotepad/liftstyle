import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/screens/widgets/productCard.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<product>>(context);

    return Scaffold(
        body: Stack(children: [
      ListView(
        padding: EdgeInsets.only(
          top: 108.0,
          bottom: 12.0,
        ),
        children: products
            .map((e) => ProductCard(
                  item: e,
                ))
            .toList(),
      ),
      CustomActionBar(
        hasBackArrrow: false,
        showAddButton: true,
        title: "Home",
        hasBackground: false,
        showCart: true,
      ),
    ]));
  }
}
