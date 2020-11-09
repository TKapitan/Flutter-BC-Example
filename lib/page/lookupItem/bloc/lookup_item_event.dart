import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tka_demo/model/item_model.dart';

abstract class LookupItemEvent extends Equatable {
  const LookupItemEvent();
}

class LookupItemLoaded extends LookupItemEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LookupItemBlockItemPushed extends LookupItemEvent {
  final ItemModel onItem;

  LookupItemBlockItemPushed({
    @required this.onItem,
  });

  @override
  List<Object> get props => [
        this.onItem,
      ];
}

class LookupItemUnBlockItemPushed extends LookupItemEvent {
  final ItemModel onItem;

  LookupItemUnBlockItemPushed({
    @required this.onItem,
  });

  @override
  List<Object> get props => [
        this.onItem,
      ];
}

class LookupItemSearchFieldFilled extends LookupItemEvent {
  final String itemToFind;

  const LookupItemSearchFieldFilled({
    @required this.itemToFind,
  }) : super();

  @override
  List<Object> get props => [
        this.itemToFind,
      ];
}
