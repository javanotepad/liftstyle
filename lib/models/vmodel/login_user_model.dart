import 'package:liftstyle/models/vmodel/product.dart';

import 'cart.dart';

class loginModel {
  String? uid = null;
  String? email = null;
  String? password = null;
  String? FullName;
  bool? Gender;
  int? Age;
  int? length;
  int? wight;
  String? img = null;
  String? msg = null;
  bool? isAdmin;
  String? bio;
  String? type;
  String? phone;
  loginModel();

  loginModel.loginResponse(this.uid, this.email, this.img);
  loginModel.loginRequest(this.email, this.password);
  loginModel.error(this.msg);
}

class loggedUserModel {
  loginModel? user;
  List<product>? products;
  List<Cart>? usercart;
  loggedUserModel({this.user, this.products, this.usercart});
}
