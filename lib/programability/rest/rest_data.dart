import 'package:flutter/material.dart';
import 'package:tka_demo/page/components/list_item.dart';

import '../session_manager.dart';

abstract class RestData {
  String _fullApiName;
  String _apiURL;

  RestData({
    @required String pApiName,
    String pApiUrl,
  }) {
    this._fullApiName = pApiName;
    this._apiURL = SessionManager.defaultApiURL;
    if (pApiUrl != null && pApiUrl != '') {
      this._apiURL = pApiUrl;
    }
  }

  String fullApiURL() {
    return this._apiURL + this._fullApiName;
  }

  RestData fromJson(Map<String, dynamic> json);

  ListItem asListItem();

  RestData clone();
}
