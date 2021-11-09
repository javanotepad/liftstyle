import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/shared/authentication/loginScreen.dart';
import 'package:liftstyle/screens/shared/home/productListView.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/services/products_services.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

import 'navHome.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage(String title, {Key? key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);

    if (user.uid == null) {
      return LoginScreen();
    } else {
      return StreamProvider<List<product>>.value(
        value: ProductService().products,
        //  initialData: ProductService().products,
        initialData: [],
        child: Scaffold(
          body: Column(
            children: [
              Container(
                child: Text("HOME"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
