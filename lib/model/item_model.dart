import 'package:flutter/material.dart';
import 'package:tka_demo/page/components/list_item.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';

class ItemModel extends RestData {
  static const String apiName = 'items';
  String number, displayName;
  bool blocked;

  ItemModel()
      : super(
          pApiName: apiName,
        );

  @override
  RestData fromJson(Map<String, dynamic> json) {
    this.number = json['number'];
    this.displayName = json['displayName'];
    this.blocked = json['blocked'];
    return this;
  }

  @override
  ListItem asListItem() {
    return ListItem(
      title: 'Item No:' + this.number.toString(),
      subtitle: this.displayName,
      itemColor: (this.blocked) ? Colors.red : Colors.white,
    );
  }

  @override
  RestData clone() {
    return ItemModel();
  }
}
