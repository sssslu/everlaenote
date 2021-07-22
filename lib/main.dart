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
      home: EisenhowerPage(title: 'everlaenote'),
    );
  }
}


