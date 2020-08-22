import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:tka_demo/programability/rest/rest_data.dart';

class RestManager {
  static Future<RestData> fetch(RestData _fetch) async {
    final response = await http.get(_fetch.fullApiURL());

    if (response.statusCode == 200) {
      return _fetch.fromJson(JSON.jsonDecode(response.body));
    } else {
      throw Exception(_fetch.toString());
    }
  }
}
