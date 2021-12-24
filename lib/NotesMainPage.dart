import 'dart:math';

import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'noteNormal/NoteCreationType1.dart';
import 'noteNormal/NoteViewType1.dart';
import 'public.dart' as p;
import 'model/noteObjectsDAO.dart';
import 'model/noteObjects.dart';

class NotesMainPage extends StatefulWidget {
  final NoteBook n;

  NotesMainPage({Key key, @required this.n}) : super(key: key);

  @override
  _NotesMainPage createState() => _NotesMainPage(n: n);
}

class _NotesMainPage extends State<NotesMainPage> {
  final NoteBook n;

  _NotesMainPage({@required this.n});

  NoteObjectsDAO noDao = new NoteObjectsDAO();

  Future<List<CommonNoteForDisplay>> getAllNotesInSpecificNoteBook() async {
    print("노트북 아이디 : " + n.id.toString());
    List<NoteChecklist> nc = [];
    List<NoteNormal> nn = [];
    List<CommonNoteForDisplay> cn = [];

    nc = await noDao.getAllNoteChecklistsFromDB(n.id);
    nn = await noDao.getAllNoteNormalsFromDB(n.id);

    print("nc 내의 정보 : " + nc.toString());
    for (NoteChecklist i in nc) {
      CommonNoteForDisplay k;
      k.originalId = i.id;
      k.title = i.noteTitle;
      k.context = "체크리스트 노트";
      k.type = 2;
      cn.add(k);
    }
    print("nc 타입 2 노트 배열 저장 완료");
    print("nn 내의 정보 : " + nn.toString());
    for (NoteNormal i in nn) {
      CommonNoteForDisplay k = new CommonNoteForDisplay(i.id, i.noteTitle, i.noteContext, 1);
      cn.add(k);
    }
    print("nn 타입 1 노트 배열 저장 완료");

    return cn;
  }

  addQuickNote() async {}

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      marginEnd: 18,
      marginBottom: 20,
      icon: Icons.add,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: p.colorMatcher(-1),
      overlayOpacity: 0.25,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: p.colorMatcher(6),
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(
            Icons.add_box_rounded,
            color: Colors.white,
          ),
          backgroundColor: p.colorMatcher(-1),
          label: '일반 노트 생성',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotesCreationType1(noteBookId: this.n.id)));//여기 페이지에서 제목, 내용, 타입1 로 노트 생성
            setState(() {});
          },
        ),
        SpeedDialChild(
          child: Icon(
            Icons.add_box_rounded,
            color: Colors.white,
          ),
          backgroundColor: p.colorMatcher(-1),
          label: '체크리스트 노트 생성',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotesCreationType2(n: this.n)));// 여기페이지에서 제목, "체크리스트", 타입 2로 노트 생성
          },
        ),
      ],
    );
  }

  deleteNote(CommonNoteForDisplay i) async{

  }
  editNote(CommonNoteForDisplay i)async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  child: Container(
                    width: 30,
                  ),
                  onTap: () {
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteBookListPage()));
                  },
                ),
                InkWell(
                  onLongPress: () async {},
                  child: Text(
                    n.noteBookTitle,
                    style: TextStyle(
                      color: p.colorMatcher(n.noteBookColor+10),//더진하게
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                InkWell(
                    child: Icon(
                      CupertinoIcons.return_icon,
                      color: p.colorMatcher(0),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    })
              ])),
          Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.99,
              child: FutureBuilder(
                  future: getAllNotesInSpecificNoteBook(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return CircularProgressIndicator();
                    } else
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            for (CommonNoteForDisplay i in snapshot.data)
                              InkWell(
                                child: Container(
                                    height: MediaQuery.of(context).size.height * 0.09,
                                    width: MediaQuery.of(context).size.width * 0.99,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: p.colorMatcher(n.noteBookColor), width: 3)),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                    child: Center(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      Text(
                                        i.title,
                                        style: TextStyle(color: p.colorMatcher(0), fontSize: 20),
                                      ),
                                      Text(
                                        i.context,
                                        style: TextStyle(color: p.colorMatcher(0), fontSize: 13),
                                      ),
                                    ]))),
                                onTap: () {
                                  if (i.type == 1) {;
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotesViewType1(noteId: i.originalId)));
                                  } else if (i.type == 2) {
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotesViewType2(n: this.n)));
                                  }
                                },
                                onLongPress: () {
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Center(
                                            child: Text(
                                              "노트 편집",
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: p.colorMatcher(10),
                                                            border: Border.all(
                                                              color: p.colorMatcher(5),
                                                            ),
                                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                                        height: 40,
                                                        width: 200,
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                                                        child: Center(child: Text("노트 삭제"))),
                                                    onTap: () {
                                                      deleteNote(i);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                        height: 40,
                                                        width: 200,
                                                        decoration: BoxDecoration(
                                                            color: p.colorMatcher(12),
                                                            border: Border.all(
                                                              color: p.colorMatcher(5),
                                                            ),
                                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                                                        child: Center(child: Text("노트북 편집"))),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await editNote(i);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              )
                          ],
                        ),
                      );
                  })),
        ],
      )),
      floatingActionButton: buildSpeedDial(),
    );
  }

  int randomIntMaker() {
    //10-15
    return Random().nextInt(6) + 10;
  }
}

class CommonNoteForDisplay {
  int originalId = -1;
  int type = 0;
  String title = "";
  String context = ""; //노트체크리스트스 인 경우 요약내용이 들어오지 않으므로 여기서 초기화.
  CommonNoteForDisplay(int a, String b, String c, int d) {
    this.originalId = a;
    this.type = 0;
    this.title = b;
    this.context = c;
    this.type = d;
  }
}
