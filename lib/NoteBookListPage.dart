import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'public.dart' as p;

class NoteBookListPage extends StatefulWidget {
  @override
  _NoteBookListPage createState() => _NoteBookListPage();
}

class _NoteBookListPage extends State<NoteBookListPage> {
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
                  child: Icon(
                    Icons.amp_stories,
                    color: colorMatcher(0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteBookListPage()));
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
                      Icons.settings,
                      color: colorMatcher(0),
                    ),
                    onTap: () {
/*                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SettingPage()), (route) => false);*/

                      print("세팅 메뉴로 이동");
                    })
              ])),
          noteListMaker(getAllNoteBookList(), colorMatcher(1)),
        ],
      )),
      floatingActionButton: buildSpeedDial(),
    );
  }

  getAllNoteBookList() {
    List<String> a = ["az"];
    a.add("adsfasd");
    a.add("qieirqwej");
    print(a.toString());
    return a;
  }

  Column noteListMaker(List<String> l, Color ccolor) {
    return Column(
      children: [
        InkWell(
          child: Container(
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0.005,
                0,
              ),
              width: MediaQuery.of(context).size.width * 0.46,
              height: 25,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: ccolor, width: 2), color: Colors.white),
              child: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "노트북 리스트",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]))),
          onTap: () {
            print("아무기능 없습니다~");
          },
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.005,
            MediaQuery.of(context).size.width * 0.005,
            MediaQuery.of(context).size.width * 0.005,
            MediaQuery.of(context).size.width * 0.001,
          ),
          width: MediaQuery.of(context).size.width * 0.46,
          height: MediaQuery.of(context).size.height * 0.42 - 20,
          child: ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: l.length,
            itemBuilder: (BuildContext context, int index) {
              final item = l[index].hashCode.toString();
              return Slidable(
                key: Key(item),
                child: noteTitleMaker(l, index),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.2,
                direction: Axis.horizontal,
                actions: <Widget>[
                  slideMakerDelete(l, index),
                  IconSlideAction(
                    color: colorMatcher(6),
                    icon: Icons.keyboard_arrow_up,
                    onTap: () => moveUp(l, index),
                  ),
                  IconSlideAction(
                    color: colorMatcher(6),
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => moveDown(l, index),
                  )
                ],
              );
            },
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ccolor, width: 2),
          ),
        ),
      ],
    );
  }

  noteTitleMaker(snapshot, index) {}

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
    /*await cmd.switchEisenMemoFromDB(snapshot.data[whatMatrix][index - 1].id, snapshot.data[whatMatrix][index].id);*/
    setState(() {});
  }

  moveDown(dynamic snapshot, int index) async {
    print("down");
    /*await cmd.switchEisenMemoFromDB(snapshot.data[whatMatrix][index + 1].id, snapshot.data[whatMatrix][index].id);*/
    setState(() {});
  }

  IconSlideAction slideMakerDelete(dynamic snapshot, int index) {
    return IconSlideAction(
        color: Colors.red,
        icon: CupertinoIcons.delete_solid,
        onTap: () {
          /*deleteEisenMemo(snapshot.data[whatmatrix][index].id);*/
          setState(() {});
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
