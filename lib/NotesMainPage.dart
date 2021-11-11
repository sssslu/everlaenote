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

  Future<List<CommonNoteForDisplay>> getAllNotes() async {
    List<NoteChecklist> nc = [];
    List<NoteNormal> nn = [];
    List<CommonNoteForDisplay> cn = [];
    nc = await noDao.getAllNoteChecklistsFromDB();
    nn = await noDao.getAllNoteNormalsFromDB();

    for (NoteChecklist i in nc) {
      CommonNoteForDisplay k;
      k.originalId = i.id;
      k.title = i.noteTitle;
      k.brief = "체크리스트 노트";
      k.type = 2;
      cn.add(k);
    }
    print("타입 2 노트 배열 저장 완료");

    for (NoteNormal i in nn) {
      CommonNoteForDisplay k;
      k.originalId = i.id;
      k.title = i.noteTitle;
      k.brief = i.noteContext;
      k.type = 1;
      cn.add(k);
    }
    print("타입 1 노트 배열 저장 완료");

    return cn;
  }

  deleteNoteBook(NoteBook i) async {
    await noDao.deleteNoteBookFromDB(i);
    setState(() {});
  }

  addQuickNote() async {}

  createNoteBook() {
    _titleController.text = "";
    _contextController.text = "";
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "노트북 추가",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: '노트북 이름',
                              border: UnderlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            //Normal textInputField will be displayed
                            maxLines: 5,
                            // when user presses enter it will adapt to it
                            controller: _contextController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: '설명',
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: Text(
                              "만들기",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (_titleController.text == "") {
                                return; //TODO 노트북 제목 같으면 걸러내는 함수 제작해야함.
                              }
                              await noDao.insertNoteBook(_titleController.text, _contextController.text, randomIntMaker());
                              Navigator.pop(context);
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  dynamic editNoteBook(NoteBook c) {
    _titleController.text = c.noteBookTitle;
    _contextController.text = c.noteBookBrief;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "노트북 편집",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: p.colorMatcher(c.noteBookColor), width: 3)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                labelText: "노트북 제목",
                                border: UnderlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              //Normal textInputField will be displayed
                              maxLines: 5,
                              // when user presses enter it will adapt to it
                              controller: _contextController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                labelText: '내용',
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text(
                                "저장",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (_titleController.text == "") {
                                  return; //TODO 경고창 추가해야함
                                }
                                await noDao.updateNoteBookInDB(c.id, _titleController.text, _contextController.text);
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

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
          onTap: () {},
        ),
        SpeedDialChild(
          child: Icon(
            Icons.add_box_rounded,
            color: Colors.white,
          ),
          backgroundColor: p.colorMatcher(-1),
          label: '체크리스트 생성',
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
                      color: p.colorMatcher(-1),
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
                  future: getAllNotes(),
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
                                        i.brief,
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
    //20-25 가 나와야함
    return Random().nextInt(6) + 20;
  }
}

class CommonNoteForDisplay {
  int originalId;
  int type;
  String title;
  String brief = ""; //노트체크리스트스 인 경우 요약내용이 들어오지 않으므로 여기서 초기화.
}
