import 'dart:convert';
import 'package:kf_online/modals/data_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LupaPasswords extends StatefulWidget {
  @override
  _LupaPasswordsState createState() => _LupaPasswordsState();
}

class _LupaPasswordsState extends State<LupaPasswords> {
  String email;
  final _key = new GlobalKey<FormState>();

  check() {
    kirimpass();
  }

  kirimpass() async {
    final response =
        await http.post(BaseUrl.lupaPassword, body: {"email": email});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 0) {
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
    } else {
      setState(() {
        // set up the button
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Terimakasih"),
          content: Text("Silahkan cek email untuk mengetahui password Anda."),
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
    }
  }

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
            color: Colors.teal[50],
            height: MediaQuery.of(context).size.height * 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Klik KF",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Masukan email yang anda gunakan !",
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
      key: _key,
      // autovalidate: true,
      child: Column(
        children: <Widget>[
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
                labelText: 'Tulis Email',
                labelStyle: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_key.currentState.validate()) {
                check();
                print("email anda  :" + email);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.84,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Center(
                child: Text(
                  'Kirim Password ke Email ',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
