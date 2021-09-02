import 'dart:convert';

import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/view/chat.dart';
import 'package:kf_online/modals/commons.dart';
import 'package:kf_online/modals/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kf_online/view/history_chat.dart';
import 'package:kf_online/view/lokasi.dart';
import 'package:kf_online/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = [];

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
                color: Colors.white,
                onPressed: () {},
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
                color: Colors.white70,
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()))
                },
              ),
              SizedBox(width: 7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
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
                                      fontSize: 30, color: Colors.black87),
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
                                          planetCard,
                                          planetThumbnail,
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
                                                          child: Text(
                                                              '\n                               Apt. ' +
                                                                  lst[index][
                                                                          'full_name']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      17.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
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
                                                            top: 33.0),
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
                                                                                user[3]),
                                                                            userTo: User(lst[index]['username'].toString(), ['password'].toString(), lst[index]['full_name'].toString(), lst[index]['email'].toString()))));
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
                                                                              .w500))),
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

final planetThumbnail = new Container(
  alignment: FractionalOffset.centerLeft,
  child: new Image(
    image: new AssetImage("assets/asset1.png"),
    height: 170.0,
    width: 170.0,
  ),
);

final planetCard = new Container(
  padding: const EdgeInsets.only(top: 30.0),
  height: 174.0,
  decoration: new BoxDecoration(
    color: Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.all(color: Colors.teal),
    boxShadow: <BoxShadow>[
      new BoxShadow(
        color: Colors.white60,
        blurRadius: 4.0,
        offset: new Offset(0.0, 10.0),
      ),
    ],
  ),
);
