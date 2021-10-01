import 'package:flutter/material.dart';
import 'package:kf_online/modals/commons.dart';
import 'package:kf_online/view/bottom_nav.dart';
import 'package:kf_online/view/daftar.dart';
import 'package:kf_online/view/lupa_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  String username;
  String fullName;
  String isOnline;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  savePref(String username, String fullName, String email, String password,
      String image, isOnline) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("username", username);
      preferences.setString("full_name", fullName);
      preferences.setString("email", email);
      preferences.setString("password", password);
      preferences.setString("image", image);
      preferences.setString("is_online", isOnline);
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      fullName = preferences.getString("fullName");
      email = preferences.getString("email");
      password = preferences.getString("password");
      if (username != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return BottomNav();
            },
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    print(username);
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
            )),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Selamat Datang di \nKomunikasi Online Apoteker",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.teal,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 35.0),
                          child: Image.asset(
                            'assets/asset6.png',
                            scale: 1,
                          ),
                        ),
                        _formBuilder(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formBuilder() {
    return Form(
      key: formKey,
      // autovalidate: true,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.teal),
              validator: (value) {
                return value.isEmpty ? "Email Tidak Boleh Kosong" : null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5)),
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.teal),
              validator: (value) {
                return value.isEmpty ? "Password Tidak Boleh Kosong" : null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5)),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LupaPasswords();
                    },
                  ),
                );
              },
              child: Text(
                'Lupa Password ?',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Raleway'),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState.validate()) {
                var res = await Common.login(emailController.text.toString(),
                    passwordController.text.toString());
                if (res != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return BottomNav();
                      },
                    ),
                  );
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.83,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextButton(
              child: Text(
                'Buat akun',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Raleway'),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Daftar();
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
