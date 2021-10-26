import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/wrapper.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  //await FirebaseAuth.instance.signOut();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
        home: Wrapper(),
      ),
    );
  }
}
