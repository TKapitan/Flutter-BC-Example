import 'package:flutter/material.dart';

class ListFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: const CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
  }
}
