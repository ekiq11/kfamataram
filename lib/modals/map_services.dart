import 'package:http/http.dart' as http;
import 'package:kf_online/modals/map_json.dart';

class LokasiServices {
  static const String url =
      'https://wisatakuapps.com/kf_api/kfonline/api/get_locations.php';
  static Future<List<Lokasi>> getLokasi() async {
    try {
      final response = await http.get(url);

      if (200 == response.statusCode) {
        final List<Lokasi> menu = lokasiFromJson(response.body);
        return menu;
      } else {
        return <Lokasi>[];
      }
    } catch (e) {
      return <Lokasi>[];
    }
  }
}
