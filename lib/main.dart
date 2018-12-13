import 'package:flutter/material.dart';
import 'package:show_demo/UI/show_list.dart';

void main() async {
  runApp(new ShowApp());
}

class ShowApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.yellowAccent,
        fontFamily: 'Ubuntu'
      ),
      home: new ShowList(),
    );
  }
}
