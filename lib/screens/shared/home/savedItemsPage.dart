import 'package:flutter/material.dart';
import 'package:liftstyle/utilities/constants.dart';

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage ({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SavedItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Saved",style: regularDarkText,),
    );
  }
}
