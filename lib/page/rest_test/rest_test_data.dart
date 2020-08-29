import 'package:tka_demo/programability/rest/rest_data.dart';

class RESTTestData extends RestData {
  static const String apiName = 'comments/1';
  int postId, id;
  String name, email, body;

  RESTTestData()
      : super(
          pApiName: apiName,
        );

  @override
  RESTTestData fromJson(Map<String, dynamic> json) {
    this.postId = json['postId'];
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.body = json['body'];

    return this;
  }
}
