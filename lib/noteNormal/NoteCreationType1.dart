import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../public.dart' as p;
import '../model/noteObjectsDAO.dart';
import '../model/noteObjects.dart';

class NotesCreationType1 extends StatefulWidget {
  final int noteBookId;

  NotesCreationType1({Key key, @required this.noteBookId}) : super(key: key);

  @override
  _NotesCreationType1 createState() => _NotesCreationType1(noteBookId: noteBookId);
}

class _NotesCreationType1 extends State<NotesCreationType1> {
  final int noteBookId;

  _NotesCreationType1({ @required this.noteBookId});

  NoteObjectsDAO noDao = new NoteObjectsDAO();

  Future<NoteNormal> getNoteInfo() async {
    return await noDao.getNoteNormalByID(noteBookId);
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
