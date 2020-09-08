import 'package:flutter/material.dart';

import '../components/drawer.dart';

class LookupItemPage extends StatelessWidget {
  static const String routeName = '/lookupItem';
  static const String id = 'LookupItem';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lookup Items'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
