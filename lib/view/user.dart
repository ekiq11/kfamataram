import 'dart:convert';

import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/view/chat.dart';
import 'package:kf_online/modals/commons.dart';
import 'package:kf_online/modals/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  var user = [];
  String username = "",
      fullName = "",
      email = "",
      password = "",
      image = "",
      isOnline = "";

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
        body: FutureBuilder(
          future: Common.getToken(),
          builder: (context, snap) {
            if (snap.hasData && snap.data != null) {
              user = snap.data.toString().split(';');
              return Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 20.0),
                                child: Text(
                                  'Tanya Apoteker',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.teal,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  StreamBuilder(
                    stream: _stream(),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        var temp = snap.data as Future<List<dynamic>>;
                        return FutureBuilder(
                          future: temp,
                          builder: (context, snap) {
                            List<dynamic> lst = snap.data;
                            if (lst != null) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: lst.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 10.0,
                                      ),
                                      child: new Stack(
                                        children: <Widget>[
                                          new Container(
                                            padding: const EdgeInsets.only(
                                                top: 30.0),
                                            height: 174.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.teal),
                                              boxShadow: <BoxShadow>[
                                                new BoxShadow(
                                                  color: Colors.white60,
                                                  blurRadius: 4.0,
                                                  offset: new Offset(0.0, 10.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          new Container(
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: new Image.network(
                                                  'https://wisatakuapps.com/kf_api/kfonline/image/' +
                                                      lst[index]['image']
                                                          .toString()),
                                            ),
                                            height: 170.0,
                                            width: 170.0,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: ListTile(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Image.asset(
                                                          'assets/asset5.png',
                                                          height: 30.0),
                                                    ],
                                                  ),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  '\n                               Apt. ' +
                                                                      lst[index]
                                                                              [
                                                                              'username']
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontFamily:
                                                                          'Raleway')),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  lst[index]['is_online']
                                                                              .toString() ==
                                                                          'y'
                                                                      ? Icon(
                                                                          Icons
                                                                              .lens,
                                                                          color: Colors
                                                                              .teal,
                                                                          size:
                                                                              7.0)
                                                                      : Icon(
                                                                          Icons
                                                                              .lens,
                                                                          color: Colors
                                                                              .grey,
                                                                          size:
                                                                              7.0),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      lst[index]['is_online'].toString() ==
                                                                              'y'
                                                                          ? Text(
                                                                              " Online",
                                                                              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, fontFamily: 'Raleway', color: Colors.teal))
                                                                          : Text(" Offline", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800, fontFamily: 'Raleway', color: Colors.grey))
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 70.0,
                                                            top: 15.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => ChatPage(
                                                                            user: User(
                                                                                user[0],
                                                                                user[1],
                                                                                user[2],
                                                                                user[3],
                                                                                user[3]),
                                                                            userTo: User(lst[index]['username'].toString(), ['password'].toString(), lst[index]['full_name'].toString(), lst[index]['email'].toString(), lst[index]['image']))));
                                                              },
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      elevation:
                                                                          0,
                                                                      shape:
                                                                          new RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            new BorderRadius.circular(30.0),
                                                                        side: BorderSide(
                                                                            color:
                                                                                Colors.teal),
                                                                      )),
                                                              child: Text(
                                                                  'Chat Apoteker',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'Raleway'))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              );
            } else {
              return Text("Fail");
            }
          },
        ),
      ),
    );
  }

  Stream<Future<List<dynamic>>> _stream() {
    Duration interval = Duration(seconds: 1);
    Stream<Future<List<dynamic>>> stream =
        Stream<Future<List<dynamic>>>.periodic(interval, _getDokter);
    return stream;
  }

  Future<List<dynamic>> _getDokter(int value) async {
    var res = await http
        .post(BaseUrl.dataDokter, body: {'username': user[0].toString()});
    var jsonx = json.decode(res.body);
    return jsonx;
  }
}
