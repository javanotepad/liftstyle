import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:liftstyle/services/user_service.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<UserProfile> {
  bool showupdateBtn = true;
  String name = "";
  bool showsaveBtn = false;
  final AuthService _auth = AuthService();
  Gender? _gender = Gender.Female;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _length = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _name = TextEditingController();
  File? image;
  String? uid;
  String? imgurl;
  @override
  Widget build(BuildContext context) {
    final filename = image != null ? basename(image!.path) : 'No file selected';
    return Consumer<loginModel>(builder: (context, user, child) {
      uid = user.uid;
      return Scaffold(
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('userProfile').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white54, Colors.white],
                      stops: [0.1, 0.9],
                    ),
                  ),
                ),
                ListView(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  physics: BouncingScrollPhysics(),
                  children: snapshot.data!.docs
                      .where((element) => element.id == user.uid)
                      .map((document) {
                    print("FULL NAME :******************** " +
                        document.get("fullName").toString());
                    _name.text = document.get("fullName").toString();
                    _age.text = document.get("age").toString();
                    _gender = (document.get("gender").toString() == 'M'
                        ? Gender.Male
                        : Gender.Female);
                    _length.text = document.get("length").toString();
                    _weight.text = document.get("weight").toString();
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 160.0,
                            width: 160.0,
                            margin: EdgeInsets.only(top: 60.0),
                            padding: EdgeInsets.only(top: 20.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        document.get("img").toString()),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(height: 30),
                          Column(
                            children: [
                              Text(
                                "Name",
                                style: regularHeading,
                              ),
                              Text(document.get("fullName").toString()),
                              SizedBox(height: 30),
                              Text(
                                "Age",
                                style: regularHeading,
                              ),
                              Text(document.get("age").toString()),
                              SizedBox(height: 30),
                              Text(
                                "Gender",
                                style: regularHeading,
                              ),
                              Text(
                                (document.get("gender").toString() == 'M'
                                    ? 'Male'
                                    : 'Female'),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "weight",
                                style: regularHeading,
                              ),
                              Text(document.get("weight").toString()),
                              SizedBox(height: 30),
                              Text(
                                "length",
                                style: regularHeading,
                              ),
                              Text(document.get("length").toString()),
                              if (showupdateBtn) _updateButton(),
                            ],
                          )
                        ]);
                  }).toList(),
                ),
                if (showsaveBtn)
                  Container(
                    decoration: new BoxDecoration(color: Colors.white),
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 120.0,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            _buildFullNameTF(_name),
                            SizedBox(height: 30),
                            _buildGenderRD(),
                            SizedBox(height: 10),
                            _buildAgeTF(_age),
                            SizedBox(height: 10),
                            _buildLengthTF(_length),
                            SizedBox(height: 10),
                            _buildWeightTF(_weight),
                            SizedBox(height: 10),
                            _imageSelectButton(),
                            SizedBox(height: 8),
                            Text(
                              filename,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            _saveButton(),
                          ],
                        )),
                  ),
                CustomActionBar(
                  hasTitle: false,
                  showAddButton: false,
                  title: "User Profile",
                  hasBackArrrow: true,
                  showCart: false,
                )
              ],
            );
          },
        ),
      );
    });
  }

  Widget _updateButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 135.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () async {
          setState(() {
            showupdateBtn = !showupdateBtn;
            showsaveBtn = !showsaveBtn;
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.black,
        child: Text(
          'Update',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _imageSelectButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 4.0,
        onPressed: () async => selectFile(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.deepPurple,
        child: Text(
          'Change My Image',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    print("choose image btn clicked");
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => image = File(path));
    await _uploadimage();
  }

  Future _uploadimage() async {
    if (image == null) return;

    final filename = basename(image!.path);
    final dest = 'usersimages$filename';
    var item = await SharedServices.uploadUserImage(dest, image!);
    print(item.toString());
    setState(() {
      imgurl = item;
    });
  }

  Widget _saveButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final user_ = loginModel();
          user_.uid = uid!;
          user_.FullName = _name.text.toString();
          user_.Age = int.parse(_age.text.toString());
          user_.length = int.parse(_length.text.toString());
          user_.wight = int.parse(_weight.text.toString());
          user_.Gender = (_gender.toString() == Gender.Male ? true : false);
          user_.img = imgurl;

          UserService(uid: uid!).updateUserProfile(user_);
          setState(() {
            showupdateBtn = !showupdateBtn;
            showsaveBtn = !showsaveBtn;
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'Save',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildGenderRD() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        ListTile(
          title: Text(
            'Male',
            style: radioTextStyle,
          ),
          leading: Radio<Gender>(
            value: Gender.Male,
            groupValue: _gender,
            onChanged: (Gender? value) {
              setState(() {
                _gender = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text(
            'Female',
            style: radioTextStyle,
          ),
          leading: Radio<Gender>(
            value: Gender.Female,
            groupValue: _gender,
            onChanged: (Gender? value) {
              setState(() {
                _gender = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAgeTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Age',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            // obscureText: true,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            controller: controller,
            validator: (val) {
              if (val!.isEmpty)
                return 'Empty';
              else {
                if (int.parse(val) < 18)
                  return 'Should be greater than 18 years!';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.add_rounded,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter your Age',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeightTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Weight',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            // obscureText: true,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            controller: controller,
            validator: (val) {
              if (val!.isEmpty)
                return 'Empty';
              else {
                if (int.parse(val) < 18)
                  return 'Should be greater than 18 years!';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.add_rounded,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter your Age',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLengthTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Length',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            // obscureText: true,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            controller: controller,
            validator: (val) {
              if (val!.isEmpty)
                return 'Empty';
              else {
                if (int.parse(val) < 18)
                  return 'Should be greater than 18 years!';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.add_rounded,
                color: Colors.deepPurpleAccent,
              ),
              hintText: 'Enter your Age',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFullNameTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: TextStyle(color: Colors.indigo),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            controller: controller,
            validator: (val) => (!val!.isEmpty ? null : "Full name is empty"),
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black45,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
