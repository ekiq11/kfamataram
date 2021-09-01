import 'package:kf_online/modals/history.dart';

import 'package:kf_online/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:kf_online/view/lokasi.dart';
import 'package:kf_online/view/profile.dart';
import 'package:kf_online/view/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryChat extends StatefulWidget {
  @override
  _HistoryChatState createState() => _HistoryChatState();
}

class _HistoryChatState extends State<HistoryChat> {
  List<ChatUser> _historyChat;
  final GlobalKey<RefreshIndicatorState> _onRefresh =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    String username = "";

    _getPref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString("username");
        print(username);
        ChatServices.getHistory(username).then((historyChat) {
          setState(() {
            _historyChat = historyChat;
          });
        });
      });
    }

    setState(() {
      _getPref();
    });
  }

  String username = "";

  Future<void> _refresh() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      print(username);
      ChatServices.getHistory(username).then((historyChat) {
        setState(() {
          _historyChat = historyChat;
        });
      });
    });
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
          toolbarHeight: 100.0,
          title: Column(
            children: [
              new Row(
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
              Column(
                children: [
                  Text("Percakapan", style: TextStyle(color: Colors.teal))
                ],
              )
            ],
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RefreshIndicator(
              onRefresh: _refresh,
              key: _onRefresh,
              child: ListView.builder(
                itemCount: _historyChat == null ? 0 : _historyChat.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.teal, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(Icons.chat_bubble_outlined,
                              color: Colors.teal[300], size: 30.0),
                          title: Text(_historyChat[index].userTo,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
                onPressed: () {},
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
      ),
    );
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
