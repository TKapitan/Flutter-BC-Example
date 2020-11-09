import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tka_demo/page/components/list_item.dart';
import 'package:tka_demo/page/lookupItem/bloc/lookup_item_event.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';

class ItemModel extends RestData {
  String id, number, displayName;
  bool blocked;

  ItemModel({
    @required Bloc fromBloc,
  }) : super(
          apiPublisher: 'keptyCZ',
          apiGroup: 'flutterExample',
          apiVersion: 'v1.0',
          apiName: 'items',
          fromBloc: fromBloc,
        );

  @override
  String asKeyFieldsODataRecordIdentificationString() {
    return '(\'' + this.number + '\')';
  }

  @override
  RestData fromJson(Map<String, dynamic> json) {
    super.eTag = json['@odata.etag'];
    this.id = json['id'];
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
      secondaryActions: [
        _blockUnblockSlideAction(),
      ],
    );
  }

  IconSlideAction _blockUnblockSlideAction() {
    return (this.blocked)
        ? IconSlideAction(
            caption: 'Unblock',
            color: Colors.green,
            icon: Icons.undo,
            onTap: () => fromBloc.add(
              LookupItemUnBlockItemPushed(
                onItem: this,
              ),
            ),
          )
        : IconSlideAction(
            caption: 'Block',
            color: Colors.red,
            icon: Icons.block,
            onTap: () => fromBloc.add(
              LookupItemBlockItemPushed(
                onItem: this,
              ),
            ),
          );
  }

  @override
  RestData clone() {
    return ItemModel(
      fromBloc: this.fromBloc,
    );
  }
}
