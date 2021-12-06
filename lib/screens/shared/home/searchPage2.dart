import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/widgets/custom_input.dart';
import 'package:liftstyle/screens/widgets/productCard.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
/*
class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("products");
  String _searchString = "";

  get _getProductCard =>  ProductCard(
  item: e,
  );

  @override
  Widget build(BuildContext context) {
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
            FutureBuilder<QuerySnapshot>(
              future: productsRef
                  .orderBy("search_string")
                  .startAt([_searchString]).endAt(
                      ["$_searchString\uf8ff"]).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // Collection Data ready to display
                if (snapshot.connectionState == ConnectionState.done) {
                  // Display the data inside a list view
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 128.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data!.docs.map(_productList).toList();
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInput(
              hintText: "Search here...",
              onSubmitted: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
              },
            ),
          ),
        ],
      ),
    );


  }

  List<product> _productList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print("DOC ID: " + doc.id);
      print("DOC NAME: " + doc.get('prdname'));
      print("PRICE: " + doc.get('prdprice').toString().trim());

      return product(
          prdId: doc.id.toString(),
          prdname: doc.get('prdname').toString(),
          prdprice: double.parse(doc.get('prdprice').toString().trim()),
          prddetails: doc.get('prddetails').toString(),
          prdimgurl: doc.get('prdimgurl').toString(),
          prdqty: int.parse(doc.get('prdqty').toString().trim()),
          ispromoted: doc.get('ispromoted'),
          isactive: doc.get('isactive'));
    }).toList();
  }
}
*/
