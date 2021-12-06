import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:liftstyle/models/vmodel/Subscription.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/wrapper.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/services/products_services.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:liftstyle/services/subscriptions.dart';
import 'package:provider/provider.dart';

import 'models/vmodel/cart.dart';
import 'models/vmodel/product.dart';

void main() async {
  //await FirebaseAuth.instance.signOut();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Cart()),
    StreamProvider<List<product>>.value(
        value: ProductService().products, initialData: []),
    StreamProvider<loginModel>.value(
      value: AuthService().user,
      initialData: loginModel.error("inital"),
    ),
    StreamProvider<List<loginModel>>.value(
        value: SharedServices().users, initialData: []),
    StreamProvider<List<Subscription>>.value(
        value: SubscriptionServices().subscriptions, initialData: []),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<loginModel>.value(
      value: AuthService().user,
      initialData: loginModel.error("Not Logged In"),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
