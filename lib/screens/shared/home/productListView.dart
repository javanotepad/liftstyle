import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/shared/home/productListItem.dart';
import 'package:provider/provider.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<product>>(context);
    if (products == null) {
      print("PRODUCTS IS NULL");
    } else {
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductListRow(item: products[index]);
        },
      );
    }
    return Container();
  }
}
