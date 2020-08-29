import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:tka_demo/programability/exceptions/rest_status_exception.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';

class RestManager {
  static Future<RestData> fetch(RestData _fetch) async {
    final response = await http.get(_fetch.fullApiURL());
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      return _fetch.fromJson(JSON.jsonDecode(response.body));
    }
    throw RestStatusException(statusCode, response.body);
  }
}
