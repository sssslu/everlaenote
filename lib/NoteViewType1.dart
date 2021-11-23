import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'public.dart' as p;
import 'model/noteObjectsDAO.dart';
import 'model/noteObjects.dart';

class NotesViewType1 extends StatefulWidget {
  final int noteId;

  NotesViewType1({Key key, @required this.noteId}) : super(key: key);

  @override
  _NotesViewType1 createState() => _NotesViewType1(noteId: noteId);
}

class _NotesViewType1 extends State<NotesViewType1> {
  final int noteId;
  final int noteType;

  _NotesViewType1({ @required this.noteId, @required this.noteType});

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
