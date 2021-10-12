import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:liftstyle/models/vmodel/loginUserModel.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  Future<loginUserModel?> loginUser(loginUserModel loginModel) async {
    var loginResult = await firebaseAuth.signInWithEmailAndPassword(
        email: loginModel.email, password: loginModel.password);
    if (loginResult.user != null) {
      print("User ID:" + loginResult.user!.uid.toString());
      return loginModel;
    }
    return null;
  }

  void registerToFb(String name, String email, String pass, String age) {
    print(name + ' - ' + email + ' - ' + pass + ' - ' + age);
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      dbRef
          .child(result.user!.uid)
          .set({"email": email, "age": age, "name": name}).then((res) {
        print("Added");
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
        );*/
      });
    }).catchError((err) {
      print(err);
      /*  showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });*/
    });
  }
}
