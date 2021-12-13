import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:liftstyle/models/vmodel/Subscription.dart';

import 'package:liftstyle/models/vmodel/login_user_model.dart';
import 'package:liftstyle/services/shared_services.dart';
import 'package:liftstyle/services/subscriptions.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';

class PlanCard extends StatefulWidget {
  final Subscription item;

  final bool isTrainer;
  final int index;
  const PlanCard(
      {Key? key,
      required this.item,
      required this.index,
      required this.isTrainer})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PlanCard> {
  File? file;

  String? fileurl;
  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : 'No file selected';
    final user = Provider.of<loginModel>(context);
    final users = Provider.of<List<loginModel>>(context);

    print("CUSTOMER IDs -9999999999: " +
        users.length.toString() +
        "ITEM CID: --=" +
        widget.item.customerid.toString() +
        " NNAMMED ===" +
        users
            .firstWhere((element) => element.uid == widget.item.customerid)
            .FullName
            .toString() +
        "\n *********************************" +
        widget.item.planurl.toString());
    return GestureDetector(
      onTap: () {
        /*
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                Product: item.Product!,
              ),
            ));
      */
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 145.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  ListTile(
                    /* leading: Image.network(
                      users!
                          .firstWhere(
                              (element) => element.uid == item.customerid)
                          .img
                          .toString(),
                    ),*/

                    subtitle: (widget.isTrainer == true
                        ? Text("Age: " +
                            users
                                .firstWhere((element) =>
                                    element.uid == widget.item.customerid)
                                .Age
                                .toString() +
                            " | Wight: " +
                            users
                                .firstWhere((element) =>
                                    element.uid == widget.item.customerid)
                                .wight
                                .toString() +
                            " | length: " +
                            users
                                .firstWhere((element) =>
                                    element.uid == widget.item.customerid)
                                .length
                                .toString())
                        : null),
                    title: (widget.isTrainer == true
                        ? Text("NAME: " +
                            users
                                .firstWhere((element) =>
                                    element.uid == widget.item.customerid)
                                .FullName
                                .toString())
                        : Text("Plan_" +
                            widget.index.toString() +
                            " By Trainer: " +
                            users
                                .firstWhere((element) =>
                                    element.uid == widget.item.trainerid)
                                .FullName
                                .toString())),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      if (widget.item.planurl!.isNotEmpty ||
                          widget.item.planurl != '')
                        RaisedButton(
                          child: const Text('Doownload plan'),
                          onPressed: () async {
                            await _launchInBrowser(
                                widget.item.planurl.toString());
                          },
                        ),
                      if (widget.isTrainer)
                        RaisedButton(
                          color: Colors.red,
                          onPressed: () async => selectFile(),
                          child: const Text("upload a new plan"),
                        )
                    ],
                  )
                ])),
            Container(
              height: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.2,
                    0.2,
                    0.5,
                  ],
                  colors: [
                    Colors.white54,
                    Colors.indigo,
                    Colors.teal,
                  ],
                )))),
          ],
        ),
      ),
    );
  }

  Widget _fileSelectButton() {
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
    setState(() => file = File(path));
    await _uploadimage();
    await SubscriptionServices().updateSubscription(Subscription(
        customerid: widget.item.customerid,
        trainerid: widget.item.trainerid,
        planurl: fileurl,
        active: true));
  }

  Future _uploadimage() async {
    if (file == null) return;

    final filename = basename(file!.path);
    final dest = 'plan$filename';
    var item = await SharedServices.uploadUserImage(dest, file!);
    print(item.toString());
    setState(() {
      fileurl = item;
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      //headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
