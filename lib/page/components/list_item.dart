import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title, subtitle;

  ListItem({
    @required this.title,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          this.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(this.subtitle),
      ),
    );
  }
}
