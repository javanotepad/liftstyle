import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userDetails =
      FirebaseFirestore.instance.collection("userProfile");

  Future updateUserProfile(loginModel user) async {
    return await this.userDetails.doc(uid).set({
      'age': user.Age,
      'fullName': user.FullName,
      'gender': (user.Gender == true ? 'M' : 'F')
    });
  }


}
