import 'dart:convert' as JSON;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tka_demo/programability/exceptions/rest_return_data_type_exception.dart';
import 'package:tka_demo/programability/exceptions/rest_status_exception.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';
import 'package:tka_demo/programability/rest/rest_filter.dart';

class RestManager {
  static Future<RestData> fetch({
    @required RestData sourceRestData,
    RestFilters filters,
  }) async {
    List<RestData> list = await fetchMultiple(
      sourceRestData: sourceRestData,
      filters: filters,
    );
    return list.first;
  }

  static Future<List<RestData>> fetchMultiple({
    @required RestData sourceRestData,
    RestFilters filters,
  }) async {
    String filterString = '';
    if (filters != null) {
      filterString = filters.toHttpFilterString();
    }
    final response = await http.get(
      sourceRestData.fullApiURL() + filterString,
    );
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final List<RestData> resultList = List();
      final dynamic fetchedBody = JSON.jsonDecode(response.body);

      if (fetchedBody is List) {
        fetchedBody.forEach((element) {
          resultList.add(
            sourceRestData.clone().fromJson(element),
          );
        });
      } else if (fetchedBody is Map) {
        resultList.add(
          sourceRestData.clone().fromJson(fetchedBody),
        );
      } else {
        RestReturnDataTypeException(fetchedBody.toString());
      }
      return resultList;
    }
    throw RestStatusException(statusCode, response.body);
  }
}
