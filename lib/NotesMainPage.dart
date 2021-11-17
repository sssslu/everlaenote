import 'dart:math';

import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<List<CommonNoteForDisplay>> getAllNotesInSpecificNoteBook() async {
    List<NoteChecklist> nc = [];
    List<NoteNormal> nn = [];
    List<CommonNoteForDisplay> cn = [];

    //TODO : 오너id 로 거르는 과정이 필요함.
    nc = await noDao.getAllNoteChecklistsFromDB();
    nn = await noDao.getAllNoteNormalsFromDB();

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
      print("@@@@@@@@@");
      CommonNoteForDisplay k = new CommonNoteForDisplay(i.id, i.noteTitle, i.noteContext);
      cn.add(k);
      print("#########");
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
          onTap: () async{
            await noDao.newNote(n.id, "dummy note","dum dum dum" );
            setState(() {

            });
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
          onTap: () {},
        ),
      ],
    );
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
                      color: p.colorMatcher(n.noteBookColor),
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
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: p.colorMatcher(-1), width: 3)),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                    child: Center(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      Text(
                                        i.title,
                                        style: TextStyle(color: p.colorMatcher(-1), fontSize: 20),
                                      ),
                                      Text(
                                        i.context,
                                        style: TextStyle(color: p.colorMatcher(-1), fontSize: 13),
                                      ),
                                    ]))),
                                onTap: () {
                                  if (i.type == 1) print("1타입 노트 상세 보기");
                                  if (i.type == 2) print("2타입 노트 상세 보기");
                                },
                                onLongPress: () {},
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
    //20-25
    return Random().nextInt(6) + 20;
  }
}

class CommonNoteForDisplay {
  int originalId = -1;
  int type = 0;
  String title = "";
  String context = ""; //노트체크리스트스 인 경우 요약내용이 들어오지 않으므로 여기서 초기화.
CommonNoteForDisplay(int a, String b, String c){
  this.originalId =a;
  this.type = 0;
  this.title = b;
  this.context = c;
}
}
