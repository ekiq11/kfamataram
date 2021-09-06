import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/view/edit_profile.dart';
import 'package:kf_online/view/login.dart';
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

  @override
  void initState() {
    super.initState();
    getPref();
  }

  var user = [];

  logOut() async {
    final response =
        await http.post(BaseUrl.logOut + 'username=' + '$username', body: {});
    print('$username');
    jsonDecode(response.body);
    print('$username' + " Berhasil Loguot");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
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
                  onPressed: () async {
                    logOut();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('username');
                    prefs.remove('email');
                    prefs.remove('fullName');
                    prefs.remove('password');

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginPage()));
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
      ),
    );
  }
}
