import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tka_demo/page/components/drawer.dart';

class StandardPageWrapper extends StatelessWidget {
  final String pageTitle;
  final BlocListener bodyBlocListener;

  StandardPageWrapper({
    @required this.pageTitle,
    @required this.bodyBlocListener,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.pageTitle,
        ),
      ),
      drawer: AppDrawer(),
      body: bodyBlocListener,
    );
  }
}
