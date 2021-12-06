import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/services/products_services.dart';

class CartService {
  final String uid;
  CartService({required this.uid});
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection("cart");
  final CollectionReference savedCollection =
      FirebaseFirestore.instance.collection("saved");
  final ProductService _productService = ProductService();
/*
  Future updateUserCart(Cart cart) async {
    return await this
        .cartCollection
        .doc(uid)
        .set({'productid': cart.prdId, 'uid': cart.uid});
  }

  Future addUserSavedList(Cart cart) async {
    return await this
        .savedCollection
        .add({'productid': cart.prdId, 'uid': cart.uid});
  }

  List<Cart?> _cartList(QuerySnapshot snapshot) {
    var list = snapshot.docs.map((doc) {
      print("CART ID: " + doc.id.toString());
      print("PRODUCT ID: " + doc.get('productid'));
      return Cart(doc.get('uid').toString(), doc.get('prdid'), null);
    }).toList();
    print("NUMBER OF ITEMS =" + list.length.toString());
    return list;
  }

  void countDocuments() async {
    QuerySnapshot _myDoc =
        await cartCollection.where('uid', isEqualTo: this.uid.toString()).get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    print(_myDocCount.length); // Count of Documents in Collection
  }

  Stream<List<Cart?>> get cart {
    print("Arraivaing to STREAM!");
    return cartCollection
        .where('uid', isEqualTo: this.uid.toString())
        .snapshots()
        .map(_cartList);
  }*/
}
