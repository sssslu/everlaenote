import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../public.dart' as p;
import '../model/noteObjectsDAO.dart';
import '../model/noteObjects.dart';

class NotesEditType1 extends StatefulWidget {
  final int noteId;

  NotesEditType1({Key key, @required this.noteId}) : super(key: key);

  @override
  _NotesEditType1 createState() => _NotesEditType1(noteId: noteId);
}

class _NotesEditType1 extends State<NotesEditType1> {
  final int noteId;

  _NotesEditType1({ @required this.noteId});

  NoteObjectsDAO noDao = new NoteObjectsDAO();

  Future<NoteNormal> getNoteInfo() async {
    return await noDao.getNoteNormalByID(noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        FutureBuilder(
            future: getNoteInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              } else
                return SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.1, width: double.infinity,
                      color: p.colorMatcher(4),
                      child: Text(snapshot.data.noteTitle),
                    ),
                    Container(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.9, width: double.infinity, color: p.colorMatcher(5), child: Text(snapshot.data.noteContext))
                  ]),
                );
            }
        )
    );
  }
}
