import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/screens/widgets/custom_action_bar.dart';
import 'package:liftstyle/screens/widgets/image_swipe.dart';
import 'package:liftstyle/services/auth_service.dart';
import 'package:liftstyle/services/productServices.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:liftstyle/services/user_service.dart';
import 'package:liftstyle/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AddNewProduct> {
  bool showupdateBtn = true;
  String name = "";
  bool showsaveBtn = false;
  final AuthService _auth = AuthService();
  Gender? _gender = Gender.Female;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productDetails = TextEditingController();

  // final TextEditingController _email = TextEditingController();
//  final TextEditingController _pass = TextEditingController();
  File? image;

  String? imgurl;
  @override
  Widget build(BuildContext context) {
    final filename = image != null ? basename(image!.path) : 'No file selected';
    return Consumer<loginModel>(
      builder: (context, user, child) {
        return Scaffold(
          body: Stack(
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
                                ? prd_tmp
                                : imgurl)
                          ],
                        ),
                        SizedBox(height: 30),
                        _buildProductNameTF(_productName),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildProdDetailsTF(_productDetails), // email
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildProdPriceTF(_productPrice),
                        SizedBox(height: 30),
                        //   _buildGenderRD(),
                        //     SizedBox(height: 10),
                        // _buildBioTF(_bio),
                        //  SizedBox(height: 10),
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
                title: "Add New Product",
                hasBackArrrow: true,
                showCart: false,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildProdPriceTF(TextEditingController _controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Product Price',
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
            keyboardType: TextInputType.number,
            validator: (val) {
              if (val!.isEmpty) return 'Empty';
              return null;
            },
            obscureText: false,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.money,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter Prodcut Price',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
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
          'Change Product Image',
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
          await ProductServices()
              .addNewProduct(
                  _productName.text.toString(),
                  double.parse(_productPrice.text.toString()),
                  _productDetails.text.toString(),
                  (imgurl == null || imgurl == 'null' ? prd_tmp : imgurl))
              .whenComplete(() => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                      title: Text('Operation Done'),
                      content: Text('Item Added Successfully!'))));
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

  Widget _buildProductNameTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Product Name',
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
            validator: (val) =>
                (!val!.isEmpty ? null : "Product name is empty"),
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
              hintText: 'Enter Product  Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProdDetailsTF(TextEditingController _controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Product Details',
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
            validator: (val) =>
                (!val!.isEmpty ? null : "Product Details is empty"),
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.details,
                color: Colors.deepPurple,
              ),
              hintText: 'Enter Product Details',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
