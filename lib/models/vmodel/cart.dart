import 'package:flutter/cupertino.dart';
import 'package:liftstyle/models/vmodel/product.dart';

import 'Item.dart';

class Cart extends ChangeNotifier {
  List<Item> _items = [];
  double _totalPrice = 0.0;

  void add(Item item) {
    _items.add(item);
    _totalPrice += item.price;
    notifyListeners();
  }

  double getByDollar() {
    return _totalPrice / 3.75;
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void remove(Item item) {
    _totalPrice -= item.price;
    _items.remove(item);
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Item> get basketItems {
    return _items;
  }
}
