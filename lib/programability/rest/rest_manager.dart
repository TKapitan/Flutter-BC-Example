import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:tka_demo/programability/exceptions/rest_return_data_type_exception.dart';
import 'package:tka_demo/programability/exceptions/rest_status_exception.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';

class RestManager {
  static Future<RestData> fetch(RestData fetch) async {
    List<RestData> list = await fetchMultiple(fetch);
    return list.first;
  }

  static Future<List<RestData>> fetchMultiple(RestData fetch) async {
    final response = await http.get(fetch.fullApiURL());
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final List<RestData> resultList = List();
      final dynamic fetchedBody = JSON.jsonDecode(response.body);

      if (fetchedBody is List) {
        fetchedBody.forEach((element) {
          resultList.add(
            fetch.clone().fromJson(element),
          );
        });
      } else if (fetchedBody is Map) {
        resultList.add(
          fetch.clone().fromJson(fetchedBody),
        );
      } else {
        RestReturnDataTypeException(fetchedBody.toString());
      }
      return resultList;
    }
    throw RestStatusException(statusCode, response.body);
  }
}
