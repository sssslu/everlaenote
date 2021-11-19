import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'public.dart' as p;
import 'model/noteObjectsDAO.dart';
import 'model/noteObjects.dart';

class NotesCreationType2 extends StatefulWidget {
  final NoteBook n;

  NotesCreationType2({Key key, @required this.n}) : super(key: key);

  @override
  _NotesCreationType2 createState() => _NotesCreationType2(n: n);
}

class _NotesCreationType2 extends State<NotesCreationType2> {
  final NoteBook n;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _NotesCreationType2({@required this.n});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * 0.1,width: double.infinity,
        color: p.colorMatcher(1),
        child: Text("노트 생성 페이지 입니다2."),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.9,width: double.infinity,
        color: p.colorMatcher(2),
        child: Text("내용쓰기 내용쓰기 내용내용내용222."),
      )
    ])));
  }
}
