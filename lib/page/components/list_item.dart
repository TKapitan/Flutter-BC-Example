import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListItem extends StatelessWidget {
  final String title, subtitle;
  final Color itemColor;
  final List<Widget> actions, secondaryActions;

  ListItem({
    @required this.title,
    @required this.subtitle,
    this.itemColor = Colors.white,
    this.actions,
    this.secondaryActions,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: (actions != null || secondaryActions != null),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              color: this.itemColor,
            ),
            child: ListTile(
              title: Text(
                this.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(this.subtitle),
            ),
          ),
        ),
      ),
      actions: actions,
      secondaryActions: secondaryActions,
    );
  }
}
