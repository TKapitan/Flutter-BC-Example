import 'package:flutter/material.dart';

class RestFilters {
  final List<_Filter> _appliedFilters = List();

  RestFilters filter({
    @required String field,
    @required String value,
  }) {
    _appliedFilters.add(
      _FilterField(
        field: field,
        value: value,
      ),
    );
    return this;
  }

  RestFilters and() {
    _appliedFilters.add(
      _FilterAnd(),
    );
    return this;
  }

  String toHttpFilterString() {
    if (_appliedFilters.isNotEmpty) {
      String filter = '?';
      _appliedFilters.forEach((element) {
        filter += element.toHttpFilterString();
      });
      return filter;
    }
    return '';
  }
}

abstract class _Filter {
  String toHttpFilterString();
}

class _FilterField extends _Filter {
  final String field;
  final String value;

  _FilterField({
    this.field,
    this.value,
  });

  @override
  String toHttpFilterString() {
    return field + '=' + value;
  }
}

class _FilterAnd extends _Filter {
  @override
  String toHttpFilterString() {
    return '&';
  }
}
