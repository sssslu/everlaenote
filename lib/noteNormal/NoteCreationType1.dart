import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../public.dart' as p;
import '../model/noteObjectsDAO.dart';
import '../model/noteObjects.dart';

class NotesCreationType1 extends StatefulWidget {
  //todo 여기를 수정해야함
  final int noteBookId;

  NotesCreationType1({Key key, @required this.noteBookId}) : super(key: key);

  @override
  _NotesCreationType1 createState() => _NotesCreationType1(noteBookId: noteBookId);
}

class _NotesCreationType1 extends State<NotesCreationType1> {
  final int noteBookId;

  _NotesCreationType1({@required this.noteBookId});

  NoteObjectsDAO noDao = new NoteObjectsDAO();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //여기서 제목과 내용 받아서 새로운 노트노멀 만들어야함
    return Scaffold(
      body:
        SingleChildScrollView(
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '노트 제목',
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.92,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: TextField(
                controller: _contextController,
                decoration: InputDecoration(
                  labelText: '내용',
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ]),
        )
    );
  }
}
