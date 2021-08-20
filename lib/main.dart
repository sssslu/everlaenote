import 'package:flutter/material.dart';
import 'Eisenhower.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EverlaeNote',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(appBar: EmptyAppBar(), body: EisenhowerPage()),
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}