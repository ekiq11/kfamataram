import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:kf_online/view/history_chat.dart';
import 'package:kf_online/view/lokasi.dart';
import 'package:kf_online/view/profile.dart';
import 'package:kf_online/view/user.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key key}) : super(key: key);

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  final widgetOptions = [
    UserLogin(),
    HistoryChat(),
    LokasiApotek(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.teal,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: 'Location'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: selectedIndex,
          fixedColor: Colors.white,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
