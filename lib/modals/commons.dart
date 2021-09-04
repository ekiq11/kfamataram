import 'dart:convert';

import 'package:kf_online/modals/data_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Common {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    String password = prefs.getString("password");
    String fullName = prefs.getString("full_name");
    String email = prefs.getString("email");
    String image = prefs.getString("image");

    if (username.isEmpty &&
        password.isEmpty &&
        fullName.isEmpty &&
        email.isEmpty &&
        image.isEmpty)
      return '';
    else
      return username +
          ";" +
          password +
          ";" +
          fullName +
          ";" +
          email +
          ";" +
          image;
  }

  static Future<void> setToken(String username, String password,
      String fullName, String email, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (username.isEmpty &&
        password.isEmpty &&
        fullName.isEmpty &&
        email.isEmpty &&
        image.isEmpty) {
      prefs.remove("username");
      prefs.remove("password");
      prefs.remove("full_name");
      prefs.remove("email");
      prefs.remove("image");
    } else {
      prefs.setString("username", username);
      prefs.setString("password", password);
      prefs.setString("full_name", fullName);
      prefs.setString("email", email);
      prefs.setString("image", image);
    }
  }

  static Future<String> login(String username, String password) async {
    var res = await http.post(BaseUrl.login,
        body: {'username': username, 'password': password});
    if (res.statusCode == 200) {
      if (res.body != null) {
        var jsonx = json.decode(res.body);
        await setToken(
            jsonx['username'].toString(),
            jsonx['password'].toString(),
            jsonx['full_name'].toString(),
            jsonx['email'].toString(),
            jsonx['image'].toString());
      }
      return res.body;
    } else {
      return '';
    }
  }
}
