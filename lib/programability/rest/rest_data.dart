import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tka_demo/page/components/list_item.dart';
import 'package:tka_demo/programability/session_manager.dart';

abstract class RestData {
  // Specifies link to the instance of Bloc from which the model class was initialized.
  final Bloc fromBloc;
  // Specifies identification of the API
  final String apiPublisher, apiGroup, apiVersion, apiName;
  String _apiURL;
  String eTag;

  RestData({
    String pApiUrl,
    this.apiPublisher = '',
    this.apiGroup = '',
    this.apiVersion = 'beta',
    @required this.apiName,
    @required this.fromBloc,
  }) {
    this._apiURL = SessionManager.defaultApiURL;
    if (pApiUrl != null && pApiUrl != '') {
      this._apiURL = pApiUrl;
    }
  }

  // Returns full API URL where the REST data are available
  String fullApiURL() {
    return this._apiURL + _createFullApiName();
  }

  /// Returns identification OData string of the record
  String asKeyFieldsODataRecordIdentificationString();

  /// Create RestData instance from json array
  ///
  /// [json] contains data for the newly created object. Returns RestData
  /// abstract class
  RestData fromJson(Map<String, dynamic> json);

  /// Create an instance of ListItem that defines how data from the object
  /// should be shown on list pages.
  ListItem asListItem();

  /// Create a cloned object of the same subtype of RestData
  ///
  /// The cloned object does not contain any data of the original one except the
  /// link to the bloc instance from which the model instance was created.
  /// Return instance of specific implementation of abstract RestData class.
  RestData clone();

  String _createFullApiName() {
    String fullApiName = this.apiPublisher;
    if (this.apiPublisher != '') fullApiName += '/';
    fullApiName += this.apiGroup;
    if (this.apiGroup != '') fullApiName += '/';
    fullApiName += this.apiVersion;
    if (this.apiVersion != '') fullApiName += '/';
    fullApiName += this.apiName;
    return fullApiName;
  }
}
