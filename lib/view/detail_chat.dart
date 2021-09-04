import 'dart:convert';
import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/modals/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailChat extends StatefulWidget {
  Chat user;
  Chat userTo;

  DetailChat({this.user, this.userTo});

  @override
  _DetailChatState createState() => _DetailChatState();
}

class _DetailChatState extends State<DetailChat> {
  TextEditingController _ctrlMess = TextEditingController();
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

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      // getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      // getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
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
          toolbarHeight: 120.0,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/asset4.png',
                      fit: BoxFit.contain,
                      height: 20,
                    ),
                    Container(
                        child: Image.asset(
                      'assets/asset5.png',
                      fit: BoxFit.contain,
                      height: 30,
                    ))
                  ],
                ),
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 20.0),
                          child: new IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios_new,
                                  size: 18),
                              color: Colors.teal)),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "Sdr.  " + widget.userTo.userTo,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.teal[800],
                                fontFamily: 'Raleway'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ])
            ],
          ),

          // toolbarHeight: 70.0,
          // title: new Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Image.asset(
          //       'assets/asset1.png',
          //       fit: BoxFit.contain,
          //       height: 50,
          //     ),
          //     Center(child: Text("  Apt.  " + widget.userTo.fullName)),
          //   ],
          // )
        ),
        body: Container(
          color: Colors.teal[50],
          child: StreamBuilder(
            initialData: null,
            stream: _stream(),
            builder: (context, snap) {
              if (snap.hasData) {
                var temp = snap.data as Future<List<dynamic>>;
                return Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: temp,
                      builder: (context, snap) {
                        List<dynamic> lst = snap.data;
                        if (lst != null) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: lst.length,
                              itemBuilder: (context, index) {
                                var username = lst[index]['user'];
                                var mess = lst[index]['content'].toString();

                                return Container(
                                    margin: username == widget.user.userFrom
                                        ? EdgeInsets.only(
                                            right: 2,
                                            bottom: 5,
                                            top: 5,
                                            left: 100)
                                        : EdgeInsets.only(
                                            right: 100,
                                            bottom: 5,
                                            top: 5,
                                            left: 2),
                                    padding: EdgeInsets.all(13),
                                    child: Text(
                                      mess,
                                      textAlign:
                                          username == widget.user.userFrom
                                              ? TextAlign.right
                                              : TextAlign.left,
                                      style: TextStyle(
                                          color:
                                              username == widget.user.userFrom
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                    decoration: BoxDecoration(
                                      color: username == widget.user.userFrom
                                          ? Colors.teal[300]
                                          : Colors.blueGrey[100],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ));
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Divider(
                      color: Colors.teal[800],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                                controller: _ctrlMess,
                                decoration: new InputDecoration.collapsed(
                                    hintText: "  Tulis Pesan  "),
                                style: TextStyle(fontSize: 18.0)),
                          ),
                          Row(
                            children: [
                              Container(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.image,
                                      color: Colors.teal[300],
                                    ),
                                    onPressed: () {
                                      myAlert();
                                    }),
                              ),
                              Container(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.teal[300],
                                    ),
                                    onPressed: () async {
                                      String content = _ctrlMess.text.trim();

                                      if (content.isNotEmpty) {
                                        var res = await _sendMess(content);
                                        print(res);
                                        _ctrlMess.text = "";
                                      } else {
                                        print("empty");
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Stream<Future<List<dynamic>>> _stream() {
    Duration interval = Duration(seconds: 1);
    Stream<Future<List<dynamic>>> stream =
        Stream<Future<List<dynamic>>>.periodic(interval, _getData);
    return stream;
  }

  Future<List<dynamic>> _getData(int value) async {
    var res = await http.post(BaseUrl.getMess, body: {
      'username': widget.user.userFrom,
      'email': '$email',
      'password': '$password',
      'user_to': widget.userTo.userTo
    });
    var jsonx = json.decode(res.body);

    return jsonx;
  }

  _sendMess(String content) async {
    var res = await http.post(BaseUrl.sendMess, body: {
      'email': '$email',
      'password': '$password',
      'username': widget.user.userFrom,
      'user_to': widget.userTo.userTo,
      'content': content,
    });
    return res.body;
  }
}
