import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/view/login.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  String username, fullname, password, email;

  check() {
    daftar();
  }

  daftar() async {
    final response = await http.post(BaseUrl.register, body: {
      "username": username,
      "password": password,
      "full_name": fullname,
      "email": email,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      setState(() {
        // set up the button
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LoginPage();
                },
              ),
            );
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Berhasil Daftar"),
          content: Text("Terimakasih, akun anda telah terdaftar."),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      });
    } else {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Gagal"),
        content: Text(message),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  final formKey = new GlobalKey<FormState>();

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
            )),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Klik KF",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Masukan data lengkap Anda untuk membuat Akun",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
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
              onChanged: (e) => fullname = e,
              style: TextStyle(color: Colors.teal),
              validator: (value) {
                return value.isEmpty ? "Isi nama lengkap anda" : null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5)),
                labelText: 'Nama lengkap',
                labelStyle: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onChanged: (e) => username = e,
              style: TextStyle(color: Colors.teal),
              validator: (value) {
                return value.isEmpty ? "Username harus di isi" : null;
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
              onChanged: (e) => email = e,
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
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onChanged: (e) => password = e,
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
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                check();
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.84,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextButton(
              child: Text(
                'L o g i n',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginPage();
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
