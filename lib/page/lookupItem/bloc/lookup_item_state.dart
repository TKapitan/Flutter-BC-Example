import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tka_demo/programability/rest/rest_data.dart';

abstract class LookupItemState extends Equatable {
  final String itemToFind;
  final int noOfRecordsToShow;
  final List<RestData> dataEntities;

  const LookupItemState({
    this.itemToFind = '',
    this.noOfRecordsToShow = 0,
    this.dataEntities,
  });

  @override
  List<Object> get props => [
        this.itemToFind,
        this.dataEntities,
        this.noOfRecordsToShow,
      ];
}

class LookupItemStateLoaded extends LookupItemState {
  const LookupItemStateLoaded({
    @required String itemToFind,
    @required int noOfRecordsToShow,
    List<RestData> dataEntities,
  }) : super(
          itemToFind: itemToFind,
          noOfRecordsToShow: noOfRecordsToShow,
          dataEntities: dataEntities,
        );
}

class LookupItemStateBlockedChanged extends LookupItemState {
  final LookupItemStateLoaded lastLoadedState;
  final String itemNo;
  final bool newValue;

  LookupItemStateBlockedChanged({
    @required this.itemNo,
    @required this.newValue,
    @required this.lastLoadedState,
  }) : super(
          itemToFind: lastLoadedState.itemToFind,
          noOfRecordsToShow: lastLoadedState.noOfRecordsToShow,
          dataEntities: lastLoadedState.dataEntities,
        );

  @override
  List<Object> get props => [this.itemNo, this.newValue];
}

class LookupItemStateLoading extends LookupItemState {
  const LookupItemStateLoading({
    @required String itemToFind,
  }) : super(
          itemToFind: itemToFind,
        );
}
