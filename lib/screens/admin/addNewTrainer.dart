import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/screens/widgets/image_swipe.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:liftstyle/services/user_service.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class AddNewTrainer extends StatefulWidget {
  const AddNewTrainer({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AddNewTrainer> {
  bool showupdateBtn = true;
  String name = "";
  bool showsaveBtn = false;
  final AuthService _auth = AuthService();
  Gender? _gender = Gender.Female;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _trainernumber = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
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
                          ImageSwipe(
                            imageList: [
                              (imgurl == null || imgurl == 'null'
                                  ? trainer_img_df
                                  : imgurl)
                            ],
                          ),
                          SizedBox(height: 30),
                          _buildFullNameTF(_name),
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildEmailTF(_email), // email
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildPasswordTF(_pass),
                          SizedBox(height: 30),
                          _buildGenderRD(),
                          SizedBox(height: 10),
                          _buildBioTF(_bio),
                          SizedBox(height: 10),
                          _buildTrainerNumber(_trainernumber),
                          SizedBox(height: 10),
                          //      _buildLengthTF(_length),
                          //    SizedBox(height: 10),
                          //  _buildWeightTF(_weight),
                          //  SizedBox(height: 10),
                          _imageSelectButton(),
                          SizedBox(height: 8),
                          Text(
                            filename,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          _saveButton(context),
                        ],
                      )),
                ),
                CustomActionBar(
                  hasTitle: true,
                  showAddButton: false,
                  title: "Add New Trainer",
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

  Widget _buildPasswordTF(TextEditingController _controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            controller: _controller,
            validator: (val) {
              if (val!.isEmpty) return 'Empty';
              return null;
            },
            obscureText: true,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
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

  Widget _saveButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await this
              ._auth
              .registerToFb(
                  _name.text.toString(),
                  _email.text.toString(),
                  _pass.text.toString(),
                  "0",
                  0,
                  0,
                  _bio.text.toString(),
                  imgurl,
                  2,
                  _trainernumber.text.toString())
              .whenComplete(() => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                      title: Text('Welcome to LifeStyle'),
                      content: Text('Thank you, you can login now!'))));
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

  Widget _buildBioTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Bio',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 100.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
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
                if (val.length < 100)
                  return 'Should be greater than 100 charchter!';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.info,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter Trainer Bio',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrainerNumber(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'WhatsApp',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            maxLength: 9,
            keyboardType: TextInputType.phone,
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
                if (val.length < 9) return 'Should be greater than 8 !';
              }
              return null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.call,
                color: Colors.deepPurple,
              ),
              hintText: '506123456',
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

  Widget _buildEmailTF(TextEditingController _controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 1)),
          height: 60.0,
          child: TextFormField(
            controller: _controller,
            validator: (val) => EmailValidator.validate(val!)
                ? null
                : "Please Enter Valid Email!",
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
