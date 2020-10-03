import 'package:flutter/material.dart';

class PaddedTextFormField extends StatelessWidget {
  final String label;
  final double padding;
  final Function onFieldSubmitted;
  final TextEditingController controller;

  PaddedTextFormField({
    @required this.label,
    @required this.controller,
    @required this.onFieldSubmitted,
    this.padding = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          isDense: true,
        ),
        controller: controller,
        autocorrect: false,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
