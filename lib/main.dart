import 'package:flutter/material.dart';
import 'package:tka_demo/programability/menu_configuration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: RouteConfiguration.routes,
      initialRoute: RouteConfiguration.home,
    );
  }
}
