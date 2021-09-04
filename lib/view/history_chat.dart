import 'package:kf_online/modals/detail.dart';
import 'package:kf_online/modals/history.dart';
import 'package:kf_online/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:kf_online/view/detail_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryChat extends StatefulWidget {
  @override
  _HistoryChatState createState() => _HistoryChatState();
}

class _HistoryChatState extends State<HistoryChat> {
  List<ChatUser> _historyChat;
  final GlobalKey<RefreshIndicatorState> _onRefresh =
      GlobalKey<RefreshIndicatorState>();
  String username = "", fullName = "", email = "", password = "";
  @override
  void initState() {
    super.initState();

    _getPref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString("username");
        fullName = preferences.getString("full_name");
        email = preferences.getString("email");
        password = preferences.getString("password");
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

  savePref(
      String username, String fullName, String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("username", username);
      preferences.setString("full_name", fullName);
      preferences.setString("email", email);
      preferences.setString("password", password);
      preferences.setString("password", password);
    });
  }

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
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RefreshIndicator(
              onRefresh: _refresh,
              key: _onRefresh,
              child: ListView.builder(
                itemCount: _historyChat == null ? 0 : _historyChat.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailChat(
                                  user: Chat(_historyChat[index].userFrom,
                                      _historyChat[index].userTo),
                                  userTo: Chat(
                                      _historyChat[index].userFrom.toString(),
                                      _historyChat[index].userTo.toString()))));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: username != _historyChat[index].userFrom
                          ? ListTile(
                              leading: Icon(Icons.chat_bubble_outlined,
                                  color: Colors.orange[300], size: 30.0),
                              title: Text(_historyChat[index].userFrom,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500)),
                            )
                          : Text("Refresh",
                              style: TextStyle(
                                fontSize: 0.0,
                              )),
                    ),
                  ));
                },
              ),
            ),
          ),
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
