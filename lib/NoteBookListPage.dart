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
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: 40,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  child: Container(width: 30,),
                  onTap: () {
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteBookListPage()));
                  },
                ),
                InkWell(
                  onLongPress: () async {},
                  child: Text(
                    "자유 노트북",
                    style: TextStyle(color: colorMatcher(0), fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                InkWell(
                    child: Icon(
                      CupertinoIcons.rectangle_grid_2x2,
                      color: colorMatcher(0),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => EisenhowerPage()), (route) => false);
                      print("아이젠하워 페이지로 이동");
                    })
              ])),
          Container(

            child: SingleChildScrollView(
              child: FutureBuilder(
                future: getAllNoteBooks(),
                builder:(context, snapshot) {

                }
              )
            ),
          )

        ],
      )),
      floatingActionButton: buildSpeedDial(),
    );
  }

  getAllNoteBooks() async{
    List<NoteBook> n = await noDao.getAllNoteBooksFromDB();
    List<String> s = [];
    for(NoteBook i in n){
      s.add(i.noteBookTitle);
    }
  }

  Color colorMatcher(int w) {
    switch (w) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.redAccent;
      case 4:
        return Colors.amber;
      case 0:
        return Colors.black87;
      case 5:
        return Colors.white;
      case 6:
        return Colors.deepPurple;
    }
    return Colors.green;
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
      overlayColor: Colors.black,
      overlayOpacity: 0.25,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      // orientation: SpeedDialOrientation.Up,
      // childMarginBottom: 2,
      // childMarginTop: 2,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add_box_rounded),
          backgroundColor: colorMatcher(4),
          label: '노트 생성',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => {},
          onLongPress: () => print('4 CHILD LONG PRESS'),
        ),
      ],
    );
  }
}
