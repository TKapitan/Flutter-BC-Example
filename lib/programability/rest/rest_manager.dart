import 'dart:convert' as JSON;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import 'package:tka_demo/security.dart';
import 'package:tka_demo/programability/exceptions/rest_return_data_type_exception.dart';
import 'package:tka_demo/programability/exceptions/rest_status_exception.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';
import 'package:tka_demo/programability/rest/rest_filter.dart';

class RestManager {
  static Map<String, String> _createRequestHeader() {
    Map<String, String> headers = new Map<String, String>();
    headers['Content-Type'] = "application/json";
    headers['Accept'] = "application/json";
    headers['Authorization'] = "Basic " + BASIC_AUTH_BASE64_PLACEHOLDER;
    return headers;
  }

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
    final response = await Http.get(
      sourceRestData.fullApiURL() +
          _getFiltersAsString(
            filters: filters,
          ),
      headers: _createRequestHeader(),
    );

    final int statusCode = response.statusCode;
    if (statusCode == 200) {
      return _processFetchOkResponse(
        response: response,
        sourceRestData: sourceRestData,
      );
    }
    throw RestStatusException(statusCode, response.body);
  }

  static Future<Http.Response> update({
    @required RestData sourceRestData,
    @required String recordIdentification,
    @required Map<String, String> newValues,
  }) async {
    Map<String, String> headers = _createRequestHeader();
    if (sourceRestData.eTag != null) {
      headers['If-Match'] = sourceRestData.eTag;
    }

    return Http.patch(
      sourceRestData.fullApiURL() + recordIdentification,
      headers: headers,
      body: JSON.jsonEncode(newValues),
    );
  }

  static String _getFiltersAsString({
    RestFilters filters,
  }) {
    String filterString = '';
    if (filters != null) {
      filterString = filters.toODataFilterString();
    }
    return filterString;
  }

  static List<RestData> _processFetchOkResponse({
    @required Http.Response response,
    @required RestData sourceRestData,
  }) {
    final List<RestData> resultList = List();
    final dynamic fetchedBody = JSON.jsonDecode(response.body);

    if (fetchedBody is List) {
      fetchedBody.forEach((element) {
        resultList.add(
          sourceRestData.clone().fromJson(element),
        );
      });
    } else if (fetchedBody is Map) {
      if (fetchedBody.containsKey('@odata.context')) {
        fetchedBody.forEach((key, value) {
          if (key == 'value') {
            value.forEach((element) {
              resultList.add(
                sourceRestData.clone().fromJson(element),
              );
            });
          }
        });
      } else
        resultList.add(
          sourceRestData.clone().fromJson(fetchedBody),
        );
    } else {
      RestReturnDataTypeException(fetchedBody.toString());
    }
    return resultList;
  }
}
