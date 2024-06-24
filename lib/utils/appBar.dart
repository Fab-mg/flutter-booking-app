import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  String apptitle;
  MyAppBar(this.apptitle);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(apptitle),
    );
  }
}
