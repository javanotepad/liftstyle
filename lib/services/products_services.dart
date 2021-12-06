import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liftstyle/models/vmodel/product.dart';

class ProductService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection("products");

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

  product getById(String id) {
    late product Product;
    var item = productsCollection.doc(id).get().then((doc) => {
          Product = product(
              prdId: doc.id,
              prdname: doc.get('prdname').toString(),
              prdprice: double.parse(doc.get('prdprice').toString().trim()),
              prddetails: doc.get('prddetails').toString(),
              prdimgurl: doc.get('prdimgurl').toString(),
              prdqty: int.parse(doc.get('prdqty').toString().trim()),
              ispromoted: doc.get('ispromoted'),
              isactive: doc.get('isactive'))
        });
    print("GETING PRODUCT BY ID :" + Product.prdId.toString());
    return Product;
  }

  Stream<List<product>> get products {
    return productsCollection.snapshots().map(_productList);
  }
}
