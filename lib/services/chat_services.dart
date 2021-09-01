import 'package:http/http.dart' as http;
import 'package:kf_online/modals/history.dart';

class ChatServices {
  static const String url =
      'https://wisatakuapps.com/kf_api/kfonline/api/get_history_chat.php?user=';
  static Future<List<ChatUser>> getHistory(String username) async {
    try {
      final response = await http.get(url + username);
      print(url + username);
      if (200 == response.statusCode) {
        final List<ChatUser> chat = chatUserFromJson(response.body);
        return chat;
      } else {
        return <ChatUser>[];
      }
    } catch (e) {
      return <ChatUser>[];
    }
  }
}
