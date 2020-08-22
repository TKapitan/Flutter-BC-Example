import '../session_manager.dart';

abstract class RestData {
  final String _fullApiUrl;
  String _apiURL = SessionManager.defaultApiURL;

  RestData(
    this._fullApiUrl, [
    this._apiURL,
  ]);

  String fullApiURL() {
    return this._apiURL + this._fullApiUrl;
  }

  RestData fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
