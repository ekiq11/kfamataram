// To parse this JSON data, do
//
//     final chatUser = chatUserFromJson(jsonString);

import 'dart:convert';

List<ChatUser> chatUserFromJson(String str) =>
    List<ChatUser>.from(json.decode(str).map((x) => ChatUser.fromJson(x)));

String chatUserToJson(List<ChatUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatUser {
  ChatUser({this.userFrom, this.userTo, this.newMessage});

  String userFrom;
  String userTo;
  String newMessage;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
      userFrom: json["user_from"],
      userTo: json["user_to"],
      newMessage: json["new_message"]);

  Map<String, dynamic> toJson() =>
      {"user_from": userFrom, "user_to": userTo, "new_message": newMessage};
}
