import 'dart:math';

import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'NotesMainPage.dart';
import 'public.dart' as p;
import 'model/noteObjectsDAO.dart';
import 'model/noteObjects.dart';

class NoteBookListPage extends StatefulWidget {
  @override
  _NoteBookListPage createState() => _NoteBookListPage();
}

class _NoteBookListPage extends State<NoteBookListPage> {
  NoteObjectsDAO noDao = new NoteObjectsDAO();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  getAllNoteBooks() async {
    List<NoteBook> n = await noDao.getAllNoteBooksFromDB();
    return n;
  }

  deleteNoteBook(NoteBook i) async {
    await noDao.deleteNoteBookFromDB(i);
    setState(() {});
  }

  createNoteBook() async {
    _titleController.text = "";
    _contextController.text = "";
    List<NoteBook> tmpN = await getAllNoteBooks();
    List<String> tmpNT = [];
    for (NoteBook i in tmpN) {
      tmpNT.add(i.noteBookTitle);
    }
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
                                return;
                              }
                              else if (tmpNT.contains(_titleController.text)) {
                                return;
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

  dynamic editNoteBook(NoteBook c) async{
    _titleController.text = c.noteBookTitle;
    _contextController.text = c.noteBookBrief;
    List<NoteBook> tmpN = await getAllNoteBooks();
    List<String> tmpNT = [];
    for (NoteBook i in tmpN) {
      tmpNT.add(i.noteBookTitle);
    }
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
                                  return;
                                }
                                if(tmpNT.contains(_titleController.text)){
                                  return;
                                }
                                await noDao.updateNoteBook(c.id, _titleController.text, _contextController.text);
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
          label: '노트북 생성',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () {
            createNoteBook();
          },
          onLongPress: () => print('4 CHILD LONG PRESS'),
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
                  child: Icon(
                    CupertinoIcons.search,
                    color: p.colorMatcher(0),
                    size: 40,
                  ),
                  onTap: () {
                    p.alertNotFunctioning(context);
                  },
                ),
                InkWell(
                  onLongPress: () async {},
                  child: Text(
                    "노트북들",
                    style: TextStyle(
                      color: p.colorMatcher(0),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                InkWell(
                    child: Icon(
                      CupertinoIcons.return_icon,
                      color: p.colorMatcher(0),
                      size: 40,
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => EisenhowerPage()), (route) => false);
                      print("아이젠하워 페이지로 이동");
                    })
              ])),
          Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.99,
              child: FutureBuilder(
                  future: getAllNoteBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return CircularProgressIndicator();
                    } else
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            for (NoteBook i in snapshot.data)
                              InkWell(
                                child: Container(
                                    height: MediaQuery.of(context).size.height * 0.09,
                                    width: MediaQuery.of(context).size.width * 0.99,
                                    decoration: BoxDecoration(
                                        color: p.colorMatcher(i.noteBookColor),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: p.colorMatcher(i.noteBookColor), width: 3)),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                    child: Center(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                      Text(
                                        i.noteBookTitle,
                                        style: TextStyle(color: p.colorMatcher(-1), fontSize: 20),
                                      ),
                                      Text(
                                        i.noteBookBrief,
                                        style: TextStyle(color: p.colorMatcher(-1), fontSize: 13),
                                      ),
                                    ]))),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotesMainPage(n: i)));
                                },
                                onLongPress: () {
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
                                                        child: Center(child: Text("노트북 삭제"))),
                                                    onTap: () {
                                                      deleteNoteBook(i);
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
                                                      await editNoteBook(i);
                                                    },
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                        height: 40,
                                                        width: 200,
                                                        decoration: BoxDecoration(
                                                            color: p.colorMatcher(13),
                                                            border: Border.all(
                                                              color: p.colorMatcher(5),
                                                            ),
                                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                        child: Center(child: Text("노트북 색상 변경"))),
                                                    onTap: () async {
                                                      await noDao.noteBookColorChange(i.noteBookTitle, randomIntMaker());
                                                      setState(() {});
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
    return Random().nextInt(6) + 10;
  }
}
