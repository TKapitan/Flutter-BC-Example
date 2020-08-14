import 'package:flutter/material.dart';
import 'package:tka_demo/programability/session_manager.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    Iterable<ListTile> menuItems = SessionManager(context).listMenuItems();
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: menuItems == null ? <Widget>[] : menuItems.toList(),
            ),
          ),
        ],
      ),
    );
  }
}
