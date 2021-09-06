import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kf_online/modals/data_api.dart';
import 'package:http/http.dart' as http;
import 'package:kf_online/view/history_chat.dart';
import 'package:kf_online/view/login.dart';
import 'package:kf_online/view/lokasi.dart';
import 'package:kf_online/view/profile.dart';
import 'package:kf_online/view/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Timer timer;

  String username = "", fullName = "", email = "", password = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      fullName = preferences.getString("full_name");
      email = preferences.getString("email");
      password = preferences.getString("password");
    });
  }

  _logOut() async {
    final response =
        await http.post(BaseUrl.logOut + 'username=' + '$username', body: {});
    print('$username');
    jsonDecode(response.body);
    print('$username' + " Berhasil Loguot");
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
              currentIndex: selectedIndex,
              fixedColor: Colors.white,
              onTap: onItemTapped,
            ),
          ),
        ),
        behavior: HitTestBehavior.translucent,
        onTapDown: (tapDown) {
          if (timer != null) {
            timer.cancel();
          }
          timer = Timer(Duration(minutes: 7), timeOutCallBack);
        });
  }

  void timeOutCallBack() async {
    _logOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('fullName');
    prefs.remove('password');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()));
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
