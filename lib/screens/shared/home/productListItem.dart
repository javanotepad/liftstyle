import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/product.dart';

class ProductListRow extends StatelessWidget {
  final product item;
  const ProductListRow({Key? key, required this.item}) : super(key: key);

  // ProductListRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 9.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueGrey,
          ),
          title: Text(item.prdname.toString()),
        ),
      ),
    );
  }
}
