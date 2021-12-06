import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/screens/widgets/custom_input.dart';
import 'package:liftstyle/screens/widgets/productCard.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:liftstyle/services/products_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SearchPage> {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("products");
  String _searchString = "";

  late List<product> products;
  @override
  Widget build(BuildContext context) {
    products = Provider.of<List<product>>(context);
    var searchResult = products;

    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Search Results",
                  style: regularDarkText,
                ),
              ),
            )
          else
            ListView(
              padding: EdgeInsets.only(
                top: 108.0,
                bottom: 12.0,
              ),
              children: searchResult
                  .map((e) => ProductCard(
                        item: e,
                      ))
                  .toList(),
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 100.0,
              bottom: 50.0,
            ),
            child: TextField(
              decoration: new InputDecoration(hintText: "Search in Products.."),
              onSubmitted: (String search) => {
                setState(() {
                  _searchString = search;
                  searchResult.clear();

                  searchResult = products
                      .where(
                          (element) => element.prdname!.contains(_searchString))
                      .toList();
                  print("search result count : " +
                      searchResult.length.toString() +
                      "\nPRODUCTS LIST : " +
                      products.length.toString());
                })
              },
            ),
          ),
          CustomActionBar(
            hasBackArrrow: false,
            title: "Search",
            hasBackground: false,
            showCart: true,
          )
        ],
      ),
    );
  }
}
