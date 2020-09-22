import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LookupItemEvent extends Equatable {
  const LookupItemEvent();
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
