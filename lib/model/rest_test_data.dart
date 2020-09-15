import 'package:tka_demo/page/components/list_item.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';

class RESTTestData extends RestData {
  static const String apiName = 'comments';
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

  @override
  ListItem asListItem() {
    return ListItem(
      title: '#' + this.postId.toString() + ' (' + this.email + ')',
      subtitle: this.body,
    );
  }

  @override
  RESTTestData clone() {
    return RESTTestData();
  }
}
