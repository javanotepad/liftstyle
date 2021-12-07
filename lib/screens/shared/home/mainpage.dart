import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/cart.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/models/vmodel/product.dart';
import 'package:liftstyle/screens/shared/authentication/loginScreen.dart';
import 'package:liftstyle/screens/shared/home/plansPage.dart';
import 'package:liftstyle/screens/shared/home/productsPage.dart';
import 'package:liftstyle/screens/shared/home/savedItemsPage.dart';
import 'package:liftstyle/screens/shared/home/searchPage.dart';
import 'package:liftstyle/screens/shared/home/trainersPage.dart';
import 'package:liftstyle/screens/trainer/subscribtionList.dart';
import 'package:liftstyle/screens/widgets/bottom_tabs.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/services/products_services.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';

import 'navHome.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage(String title, {Key? key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  PageController _pageController = PageController();
  int currentSelected = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page!.round() != currentSelected) {
        setState(() {
          currentSelected = _pageController.page!.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<loginModel>(context);
    if (user.uid == null) {
      return LoginScreen();
    } else {
      final cart = Provider.of<List<Cart>?>(context);
      final users = Provider.of<List<loginModel>>(context);
      // final current = Provider.of<loginModel>(context);
      print("USER ID 0000: " + user.uid.toString());
      // print("USER COUNT = " + users.length.toString());
      // loginModel us =
      var user_ = users!.where((element) => element.uid == user.uid).first;
      // print("user type == " + user_.type.toString());
      // print("USER TYPE: -------------- " + user.type.toString());

      return StreamProvider<List<product>>.value(
        value: ProductService().products,
        //  initialData: ProductService().products,
        initialData: [],
        child: Scaffold(
          drawer: NavDrawer(),
          body: PageView(
            controller: _pageController,
            children: [
              ProductsPage(),
              TrainersPage(),
              if (user_.type == 'customer') PlansPage(),
              if (user_.type == Trainer) SubscribtionList(),
            ],
          ),
          bottomNavigationBar: getBottmBar(user_),
        ),
      );
    }
  }

  BottomNavigationBar getBottmBar(loginModel user_) {
    return BottomNavigationBar(
      currentIndex: this.currentSelected,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black87,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Trainers',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            bookmark,
          ),
          label: (user_.type == Trainer ? 'Subscriptions' : 'Plans'),
          /*  BottomNavigationBarItem(
          icon: Icon(
            logout,
          ),
          label: 'Logout',
        )*/
        )
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentSelected = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
      print("index is $index");
    });
  }
}
