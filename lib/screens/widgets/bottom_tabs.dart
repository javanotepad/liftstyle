import 'package:flutter/material.dart';
import 'package:liftstyle/utilities/constants.dart';

class BottomTabs extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BottomTabs> {
  int currentSelected = 0;
  @override
  void initState() {
    this.currentSelected = 0;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      currentSelected = index;
      print("index is $index");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: this.currentSelected,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black87,
          ),
          title: new Text('Home', style: regularDarkText),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.black87,
          ),
          title: new Text(
            'Search',
            style: regularDarkText,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            bookmark,
            color: Colors.black87,
          ),
          title: new Text('Saved', style: regularDarkText),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            logout,
            color: Colors.black87,
          ),
          title: new Text('Logout', style: regularDarkText),
        )
      ],
    );
  }
}
