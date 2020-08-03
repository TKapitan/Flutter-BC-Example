import 'package:flutter/material.dart';
import 'package:tka_demo/page/home/home_page.dart';

class MenuConfiguration {
  const MenuConfiguration._();

  static final Map<String, MenuItem> menuPages = {
    HomePage.id: MenuItem(
      icon: Icons.arrow_upward,
      name: 'Home Page',
      routeName: HomePage.routeName,
    ),
  };
}

class RouteConfiguration {
  const RouteConfiguration._(); // disables class construction

  static const String home = HomePage.routeName;

  static Map<String, Widget Function(BuildContext)> get routes => {
        RouteConfiguration.home: (context) => HomePage(),
      };
}

class MenuItem {
  final IconData icon;
  final String name;
  final String routeName;

  MenuItem({
    this.icon,
    this.name,
    this.routeName,
  });
}
