import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'public.dart' as p;
import 'model/noteObjectsDAO.dart';
import 'model/noteObjects.dart';

class NoteBookListPage extends StatefulWidget {
  @override
  _NoteBookListPage createState() => _NoteBookListPage();
}

class _NoteBookListPage extends State<NoteBookListPage> {
  NoteObjectsDAO noDao = new NoteObjectsDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    "노트북들",
                    style: TextStyle(
                      color: p.colorMatcher(-1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                InkWell(
                    child: Icon(
                      CupertinoIcons.rectangle_grid_2x2,
                      color: p.colorMatcher(-1),
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
                                    color: p.colorMatcher(i.noteBookColor),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                    child: Center(
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text(
                                        i.noteBookTitle,
                                        style: TextStyle(color: p.colorMatcher(5), fontSize: 20),
                                      ),
                                      Text(
                                        i.noteBookBrief,
                                        style: TextStyle(color: p.colorMatcher(5), fontSize: 10),
                                      ),
                                    ]))),
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
                                                  InkWell(child : Container(
                                                    height: 40,
                                                    width: 200,
                                                    color: p.colorMatcher(10),
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                    child: Text("노트북 삭제")
                                                  ),
                                                  onTap: (){
                                                    deleteNoteBook(i);
                                                    Navigator.pop(context);
                                                  },
                                                  ),
                                                  InkWell(child : Container(
                                                      height: 40,
                                                      width: 200,
                                                      color: p.colorMatcher(12),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                      child: Text("노트북 편집")
                                                  ),
                                                    onTap: (){
                                                      deleteNoteBook(i);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  InkWell(child : Container(
                                                      height: 40,
                                                      width: 200,
                                                      color: p.colorMatcher(13),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                      child: Text("노트북 색상 변경")
                                                  ),
                                                    onTap: (){
                                                      deleteNoteBook(i);
                                                      Navigator.pop(context);
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

  getAllNoteBooks() async {
    List<NoteBook> n = await noDao.getAllNoteBooksFromDB();

    return n;
  }
  deleteNoteBook(NoteBook i) async{
    await noDao.deleteNoteBookFromDB(i);
    setState(() {});
  }
  moveUp(dynamic snapshot, int index) async {
    ///moveUp과 moveDown 은 그냥 위 또는 아래에 유효한 객체가 있는지 검사문을 넣지 않았다. 왜냐하면 오류가 나도 꺼지지 않기에.
    print("up");
    /*await emdao.switchEisenMemoFromDB(snapshot.data[whatMatrix][index - 1].id, snapshot.data[whatMatrix][index].id);*/
    setState(() {});
  }

  moveDown(dynamic snapshot, int index) async {
    print("down");
    /*await emdao.switchEisenMemoFromDB(snapshot.data[whatMatrix][index + 1].id, snapshot.data[whatMatrix][index].id);*/
    setState(() {});
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
          child: Icon(Icons.add_box_rounded, color: Colors.white,),
          backgroundColor: p.colorMatcher(-1),
          label: '노트북 생성',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () {
            addNote();
          },
          onLongPress: () => print('4 CHILD LONG PRESS'),
        ),
      ],
    );
  }
  addNote() async{
    await noDao.insertNoteBook("자유 노트", "", 0);
    setState(() {});
  }
}
