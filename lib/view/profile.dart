import 'package:flutter/material.dart';

import 'package:kf_online/view/edit_profile.dart';
import 'package:kf_online/view/history_chat.dart';
import 'package:kf_online/view/user.dart';
import 'package:kf_online/view/login.dart';
import 'package:kf_online/view/lokasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  savePref(
      String username, String fullName, String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("username", username);
      preferences.setString("full_name", fullName);
      preferences.setString("email", email);
      preferences.setString("password", password);
    });
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    setState(() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  var user = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80.0,
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/asset4.png',
                fit: BoxFit.contain,
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/asset5.png',
                    fit: BoxFit.contain,
                    height: 30,
                  ))
            ],
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Text("$fullName",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal)),
              SizedBox(
                height: 2,
              ),
              Text("$email",
                  style: TextStyle(fontSize: 18.0, color: Colors.teal)),
              SizedBox(
                height: 10,
                width: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return EditProfile();
                        },
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text('Edit Profile',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: ListTile(
              //       leading: Icon(
              //         Icons.book,
              //         color: Colors.white,
              //       ),
              //       title: Text('Tentang Aplikasi',
              //           style:
              //               TextStyle(color: Colors.white, fontSize: (20.0))),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  onPressed: () {
                    logOut();
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text('Keluar',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 60.0),
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 26.0,
                ),
                color: Colors.white70,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UserLogin();
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.chat_bubble,
                  size: 26.0,
                ),
                color: Colors.white70,
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryChat()))
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.location_on,
                  size: 26.0,
                ),
                color: Colors.white70,
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LokasiApotek()))
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 26.0,
                ),
                color: Colors.white,
                onPressed: () => {},
              ),
              SizedBox(width: 7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
      ),
    );
  }
}
