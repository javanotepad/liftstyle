import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServices {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection("products");

  Future<bool> addNewProduct(String productName, double price,
      String productDetails, String? productImgUrl) async {
    print("PRODUCT ADD OPERATION ..");
    bool result = false;
    await productsCollection.doc().set({
      "prddetails": productDetails,
      "prdname": productName,
      "prdprice": price,
      "prdqty": 100,
      "isactive": true,
      "ispromoted": false,
      "prdimgurl": productImgUrl,
    }).whenComplete(() => result = true);
    return result;
  }

  Future<bool> deleteProduct(String id) async {
    bool result = false;
    await productsCollection.doc(id).delete().whenComplete(() => result = true);
    return result;
  }
}
