import 'package:flutter/material.dart';
import 'package:tka_demo/programability/menu_configuration.dart';
import 'package:tka_demo/security.dart';

class SessionManager {
  static SessionManager _singleton;
  static final String defaultApiURL = BC_API_URL;
  static final List<ListTile> _resultMenu = [];

  SessionManager._internal(BuildContext context) {
    MenuConfiguration.menuPages.forEach(
      (key, value) => _resultMenu.add(ListTile(
        leading: Icon(value.icon),
        title: Text(value.name),
        onTap: () => Navigator.pushNamed(context, value.routeName),
      )),
    );
  }

  factory SessionManager(BuildContext context) {
    if (_singleton == null) {
      _singleton = new SessionManager._internal(context);
    }
    return _singleton;
  }

  Iterable<ListTile> listMenuItems() {
    return _resultMenu;
  }
}
