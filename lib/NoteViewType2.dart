import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'public.dart' as p;
import 'model/noteObjectsDAO.dart';
import 'model/noteObjects.dart';

class NotesViewType2 extends StatefulWidget {
  final NoteBook n;

  NotesViewType2({Key key, @required this.n}) : super(key: key);

  @override
  _NotesViewType2 createState() => _NotesViewType2(n: n);
}

class _NotesViewType2 extends State<NotesViewType2> {
  final NoteBook n;

  _NotesViewType2({@required this.n});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * 0.1,width: double.infinity,
        color: p.colorMatcher(4),
        child: Text("노트 보기 페이지입니다2."),
      ),
      Container(height: MediaQuery.of(context).size.height * 0.9,width: double.infinity, color: p.colorMatcher(5), child: Text("내용내용내용내용내용222"))
    ])));
  }
}
