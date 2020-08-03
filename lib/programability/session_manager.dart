import 'package:flutter/material.dart';
import 'package:tka_demo/programability/menu_configuration.dart';

class SessionManager {
  static final SessionManager _singleton = SessionManager._singletonConst();

  SessionManager._singletonConst();
  factory SessionManager() {
    return _singleton;
  }

  Iterable<ListTile> listMenuItems(BuildContext context) {
    List<ListTile> _resultMenu = [];
    MenuConfiguration.menuPages.forEach(
      (key, value) => _resultMenu.add(ListTile(
        leading: Icon(value.icon),
        title: Text(value.name),
        onTap: () => Navigator.pushNamed(context, value.routeName),
      )),
    );
    return _resultMenu;
  }
}
