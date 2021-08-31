import 'dart:convert';

import 'package:kf_online/modals/data_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatHistory {
  static Future<String> getChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userFrom = prefs.getString("user_from");
    String userTo = prefs.getString("user_to");

    if (userFrom.isEmpty && userTo.isEmpty)
      return '';
    else
      return userFrom + ";" + userTo;
  }

  static Future<void> setToken(String userFrom, String userTo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userFrom.isEmpty && userTo.isEmpty) {
      prefs.remove("user_from");
      prefs.remove("user_to");
    } else {
      prefs.setString("user_from", userFrom);
      prefs.setString("user_to", userTo);
    }
  }

  static Future<String> login(String userFrom, String userTo) async {
    var res = await http
        .post(BaseUrl.login, body: {'user_from': userFrom, 'user_to': userTo});
    if (res.statusCode == 200) {
      if (res.body != null) {
        var jsonx = json.decode(res.body);
        await setToken(
          jsonx['user_from'].toString(),
          jsonx['user_to'].toString(),
        );
      }
      return res.body;
    } else {
      return '';
    }
  }
}
