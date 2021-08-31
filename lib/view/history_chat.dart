import 'dart:convert';

import 'package:kf_online/modals/data_api.dart';
import 'package:kf_online/view/chat.dart';
import 'package:kf_online/modals/commons.dart';
import 'package:kf_online/modals/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kf_online/view/lokasi.dart';
import 'package:kf_online/view/profile.dart';
import 'package:kf_online/view/user.dart';

class HistoryChat extends StatefulWidget {
  @override
  _HistoryChatState createState() => _HistoryChatState();
}

class _HistoryChatState extends State<HistoryChat> {
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
                color: Colors.white70,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return HomePage();
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
                color: Colors.white,
                onPressed: () => {},
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
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                        child: Text(
                      "Riwayat Chat, ${user[2]}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
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
                                    return Card(
                                      child: ListTile(
                                        leading: Icon(Icons.chat_bubble_outline,
                                            color: Colors.teal, size: 30.0),
                                        title: Text(
                                            lst[index]['full_name'].toString()),
                                        subtitle: Text(
                                            lst[index]['username'].toString()),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ChatPage(
                                                      user: User(
                                                          user[0],
                                                          user[1],
                                                          user[2],
                                                          user[3]),
                                                      userTo: User(
                                                          lst[index]['username']
                                                              .toString(),
                                                          ['password']
                                                              .toString(),
                                                          lst[index]
                                                                  ['full_name']
                                                              .toString(),
                                                          lst[index]['email']
                                                              .toString()))));
                                        },
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
        Stream<Future<List<dynamic>>>.periodic(interval, _getUser);
    return stream;
  }

  Future<List<dynamic>> _getUser(int value) async {
    var res = await http
        .post(BaseUrl.getUser, body: {'username': user[0].toString()});
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
