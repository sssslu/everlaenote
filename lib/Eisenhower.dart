import 'package:everlaenote/model/eisenMemoDAO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'model/eisenMemo.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EisenhowerPage extends StatefulWidget {
  EisenhowerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EisenhowerPageState createState() => _EisenhowerPageState();
}

class _EisenhowerPageState extends State<EisenhowerPage> {
  EisenMemoDAO cmd = new EisenMemoDAO();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SharedPreferences _pref;

/*  SharedPreferences _pref;
 Future<bool> checkgetter() async {
    _pref = await SharedPreferences.getInstance();
    isCheckboxEnabled = (_pref.getBool('checkboxenabled') ?? false);
    return isCheckboxEnabled;
  }*/ //shared preferences 사용시 참고 구문
  Future<List<List<EisenMemo>>> getAllEisenMemo() async {
    print("get all @@@@@@");
    List<EisenMemo> wholeList = [];
    List<EisenMemo> iuList = [];
    List<EisenMemo> inuList = [];
    List<EisenMemo> niuList = [];
    List<EisenMemo> ninuList = [];
    List<List<EisenMemo>> wholeListList = [];
    wholeList = await cmd.getEveryEisenMemoFromDB();
    for (EisenMemo i in wholeList) {
      if (i.whatMatrix == 1) {
        iuList.add(i);
      }
      if (i.whatMatrix == 2) {
        inuList.add(i);
      }
      if (i.whatMatrix == 3) {
        niuList.add(i);
      }
      if (i.whatMatrix == 4) {
        ninuList.add(i);
      }
    }
    wholeListList.add(iuList);
    wholeListList.add(inuList);
    wholeListList.add(niuList);
    wholeListList.add(ninuList);
    print("returning future builder snap");
    return wholeListList;
  }

  showSidebar() {
    print("showing sidebar");
  }

  void viewNote(EisenMemo c) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("${c.memoTitle}"),
          content: new Text("${c.memoContext}"),
          actions: <Widget>[
            new TextButton(
              child: new Text("Edit"),
              onPressed: () {
                Navigator.pop(context);
                editMemo(c);
              },
            ),
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  dynamic editMemo(EisenMemo c) {
    _titleController.text = c.memoTitle;
    _contextController.text = c.memoContext;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "메모 수정",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: colorMatcher(c.whatMatrix), width: 3)),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: '제목',
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
                                _titleController.text = "내용 없음";
                              }
                              await cmd.insertEisenMemo(_titleController.text, _contextController.text, c.whatMatrix);
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

  dynamic createMemo(int whatmatrix) {
    print("$whatmatrix 번 매트릭스 메모 생성 시작");
    _titleController.text = "";
    _contextController.text = "";
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "메모 추가",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: colorMatcher(whatmatrix), width: 3)),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: '제목',
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
                                _titleController.text = "내용 없음";
                              }
                              await cmd.insertEisenMemo(_titleController.text, _contextController.text, whatmatrix);
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

  void deleteEisenMemo(int id) async {
    cmd.deleteEisenMemoFromDB(id);
    print("id number " + id.toString() + "deleted.");
  }

  void deleteEverything(int whatmatrix) async {
    await cmd.deleteEveryEisenMemoInSpecificList(whatmatrix);
    setState(() {});
  }

  void checkEisenMemo(int id, int isChecked) async {
    await cmd.checkStatusChange(id, isChecked);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Screen.keepOn(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.03,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: showSidebar,
                  child: Icon(
                    Icons.menu,
                    color: colorMatcher(0),
                  ),
                ),
                Text(
                  "everlae note",
                  style: TextStyle(color: colorMatcher(0), fontWeight: FontWeight.bold),
                ),
                InkWell(
                  child: Icon(
                    Icons.category_rounded,
                    color: colorMatcher(0),
                  ),
                ),
              ])),
          FutureBuilder(
              future: getAllEisenMemo(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                } else
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        mMaker1(snapshot, "긴급 & 중요", 1, colorMatcher(1)), //슬라이더블 방향 차이 때문에 부득이하게 다른 함수를 탐
                        mMaker2(snapshot, "긴급 & 안중요", 2, colorMatcher(2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        mMaker1(snapshot, "안긴급 & 중요", 3, colorMatcher(3)),
                        mMaker2(snapshot, "안긴급 & 안중요", 4, colorMatcher(4)),
                      ],
                    ),
                  ]);
              })
        ],
      )),
      floatingActionButton: buildSpeedDial(),
    );
  }

  Column mMaker1(dynamic snapshot, String titleText, int whatMMatrix, Color ccolor) {
    return Column(
      children: [
        InkWell(
          child: Container(
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0,
              ),
              width: MediaQuery.of(context).size.width * 0.46,
              height: MediaQuery.of(context).size.height * 0.03,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: ccolor, width: 2), color: Colors.white),
              child: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  titleText,
                  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.delete,
                  size: MediaQuery.of(context).size.width * 0.05,
                  color: ccolor,
                ),
              ]))),
          onLongPress: () {
            deleteEverything(whatMMatrix);
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
          height: MediaQuery.of(context).size.height * 0.42,
          child: ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: snapshot.data[whatMMatrix - 1].length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data[whatMMatrix - 1][index].hashCode.toString();
              return Slidable(
                key: Key(item),
                child: mmMaker(snapshot, whatMMatrix, index),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.2,
                direction: Axis.horizontal,
                secondaryActions: <Widget>[
                  slideMakerDelete(snapshot, index, whatMMatrix - 1),
                ],
              );
            },
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ccolor, width: 2),
          ),
        ),
      ],
    );
  }

  Column mMaker2(dynamic snapshot, String titleText, int whatMMatrix, Color ccolor) {
    return Column(
      children: [
        InkWell(
          child: Container(
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0.005,
                MediaQuery.of(context).size.width * 0,
              ),
              width: MediaQuery.of(context).size.width * 0.46,
              height: MediaQuery.of(context).size.height * 0.03,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: ccolor, width: 2), color: Colors.white),
              child: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  titleText,
                  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.delete,
                  size: MediaQuery.of(context).size.width * 0.05,
                  color: ccolor,
                ),
              ]))),
          onLongPress: () {
            deleteEverything(whatMMatrix);
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
          height: MediaQuery.of(context).size.height * 0.42,
          child: ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: snapshot.data[whatMMatrix - 1].length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data[whatMMatrix - 1][index].hashCode.toString();
              return Slidable(
                key: Key(item),
                child: mmMaker(snapshot, whatMMatrix, index),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.2,
                direction: Axis.horizontal,
                actions: <Widget>[
                  slideMakerDelete(snapshot, index, whatMMatrix - 1),
                ],
              );
            },
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ccolor, width: 2),
          ),
        ),
      ],
    );
  }

  InkWell mmMaker(dynamic snapshot, int whatMMatrix, int index) {
    return InkWell(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.459,
          child: Center(
              child: Row(children: [
            Container(width: 4),
            snapshot.data[whatMMatrix - 1][index].memoContext != ""
                ? snapshot.data[whatMMatrix - 1][index].isChecked == 1
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          snapshot.data[whatMMatrix - 1][index].memoTitle,
                          style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
                          overflow: TextOverflow.ellipsis,
                        ))
                    : (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            snapshot.data[whatMMatrix - 1][index].memoTitle,
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.02,
                            child: Text(
                              snapshot.data[whatMMatrix - 1][index].memoContext,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ))
                      ]))
                : snapshot.data[whatMMatrix - 1][index].isChecked == 1
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          snapshot.data[whatMMatrix - 1][index].memoTitle,
                          style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
                          overflow: TextOverflow.ellipsis,
                        ))
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          snapshot.data[whatMMatrix - 1][index].memoTitle,
                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ))
          ]))),
      onTap: () {
        print("체크상태변경됨@@@@@@@@@@@");
        checkEisenMemo(snapshot.data[whatMMatrix - 1][index].id, snapshot.data[whatMMatrix - 1][index].isChecked == 1 ? 0 : 1);
      },
      onLongPress: () {
        viewNote(snapshot.data[whatMMatrix - 1][index]);
      },
    );
  }

  IconSlideAction slideMakerDelete(dynamic snapshot, int index, int whatmatrix) {
    return IconSlideAction(
        caption: 'dump',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          deleteEisenMemo(snapshot.data[whatmatrix][index].id);
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
          child: Icon(Icons.crop_square),
          backgroundColor: colorMatcher(4),
          label: '안긴급&안중요',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => createMemo(4),
          onLongPress: () => print('4 CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.crop_square),
          backgroundColor: colorMatcher(3),
          label: '긴급&안중요',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => createMemo(3),
          onLongPress: () => print('3 CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.crop_square),
          backgroundColor: colorMatcher(2),
          label: '안긴급&중요',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => createMemo(2),
          onLongPress: () => print('2 CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.crop_square),
          backgroundColor: colorMatcher(1),
          label: '긴급&중요',
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => createMemo(1),
          onLongPress: () => print('1 CHILD LONG PRESS'),
        ),
      ],
    );
  }

  Color colorMatcher(int whatmatrix) {
    switch (whatmatrix) {
      case 1:
        return Colors.deepPurple;
      case 2:
        return Colors.teal;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.blueGrey;
      case 0:
        return Colors.green;
    }
    return Colors.white;
  }
}
