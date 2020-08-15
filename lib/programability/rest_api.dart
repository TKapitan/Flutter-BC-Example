import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

Future<RESTTestData> fetchRESTTestData() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/comments/1');

  if (response.statusCode == 200) {
    return RESTTestData.fromJson(JSON.jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class RESTTestData {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  RESTTestData({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory RESTTestData.fromJson(Map<String, dynamic> json) {
    return RESTTestData(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
