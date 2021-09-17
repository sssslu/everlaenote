import 'dart:math';

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

  /// 퍼블릭 변수 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  bool isCheckboxEnabled = true;

  Future<bool> checkGetter() async {
    print('체크게터 실행!');
    _pref = await SharedPreferences.getInstance();
    isCheckboxEnabled = (_pref.getBool('checkboxEnabled') ?? true);
    return isCheckboxEnabled;
  }

  checkChange() async {
    setState(() {
      isCheckboxEnabled = !isCheckboxEnabled;
      _pref.setBool('checkboxenabled', isCheckboxEnabled);
    });
  }

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

  void viewEisenNote(EisenMemo c) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("${c.memoTitle}"),
          content: new SingleChildScrollView(
            child: Text("${c.memoContext}"),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text("옮기기"),
              onPressed: () {
                Navigator.pop(context);
                moveEisenMemo(c.id);
              },
            ),
            new TextButton(
              child: new Text("수정"),
              onPressed: () {
                Navigator.pop(context);
                editEisenMemo(c);
              },
            ),
            new TextButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  dynamic moveSupporter(int whatMatrix, int id) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.3,
        margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.005,
          MediaQuery.of(context).size.width * 0.005,
          MediaQuery.of(context).size.width * 0.005,
          MediaQuery.of(context).size.width * 0.005,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colorMatcher(whatMatrix),
        ),
      ),
      onTap: () async {
        await cmd.changeEisenMemoMatrix(id, whatMatrix);
        Navigator.pop(context);
        setState(() {});
      },
    );
  }

  dynamic moveEisenMemo(int id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "메모 옮기기",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        moveSupporter(1, id),
                        moveSupporter(2, id),
                      ],
                    ),
                    Row(
                      children: [
                        moveSupporter(3, id),
                        moveSupporter(4, id),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  dynamic editEisenMemo(EisenMemo c) {
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
                  child: SingleChildScrollView(
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
                                await cmd.updateEisenMemoInDB(c.id, _titleController.text, _contextController.text);
                                Navigator.pop(context);
                                setState(() {});
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

  dynamic createEisenMemo(int whatmatrix) {
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
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SingleChildScrollView(
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

/*  void deleteEverything(int whatmatrix) async {
    await cmd.deleteEveryEisenMemoInSpecificList(whatmatrix);
    setState(() {});
  }*/

  void checkEisenMemo(int id, int isChecked) async {
    await cmd.checkStatusChange(id, isChecked);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkGetter();
    Screen.keepOn(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: 30,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  child: Icon(Icons.amp_stories),
                  onTap: () {
                    print("노트북메뉴로 이동");
                    gotoNoteBookListPage();
                  },
                ),
                InkWell(
                  onLongPress: () async {
                    eggMaker();
                    for (int i = 1; i < 10; i++) {
                      Future.delayed(Duration(milliseconds: 300 * i), () {
                        Navigator.pop(context);
                        eggMaker();
                      });
                    }
                  },
                  child: Text(
                    "Everlaenote",
                    style: TextStyle(color: colorMatcher(0), fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                    child: Icon(Icons.settings),
                    onTap: () {
                      print("세팅 메뉴로 이동");
                    })
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
                        mMaker(snapshot, "긴급 & 중요", 1, colorMatcher(1)),
                        mMaker(snapshot, "긴급 & 안중요", 2, colorMatcher(2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        mMaker(snapshot, "안긴급 & 중요", 3, colorMatcher(3)),
                        mMaker(snapshot, "안긴급 & 안중요", 4, colorMatcher(4)),
                      ],
                    ),
                  ]);
              })
        ],
      )),
      //floatingActionButton: buildSpeedDial(),
    );
  }

  ///mMaker 는 아이젠하워 매트릭스 4개중 1개의 겉 껍질과 슬라이더블 소켓을 만들어주는 역할을 한다.
  Column mMaker(dynamic snapshot, String titleText, int whatMMatrix, Color ccolor) {
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
                  titleText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]))),
          onTap: () {
            createEisenMemo(whatMMatrix);
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
          height: MediaQuery.of(context).size.height * 0.42-20,
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
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ccolor, width: 2),
          ),
        ),
      ],
    );
  }

  ///mmMaker 는 mMaker 의 슬라이더블 소켓 안쪽에 잉크웰 한 개를 만들어주는 역할을 한다. 모든 eisenMemo 객체들이 여기 사용된다.
  InkWell mmMaker(dynamic snapshot, int whatMMatrix, int index) {
    return InkWell(
      child: containerMaker(snapshot.data[whatMMatrix - 1][index], isCheckboxEnabled),
      onTap: () {
        //해당 잉크웰을 터치했을 시 동작이다(밀었을때는 이 윗단계 함수인 슬라이더블이 처리한다.)
        if (isCheckboxEnabled) {
          print("@ 체크상태변경됨 @");
          checkEisenMemo(snapshot.data[whatMMatrix - 1][index].id, snapshot.data[whatMMatrix - 1][index].isChecked == 1 ? 0 : 1);
        } else if (!isCheckboxEnabled) {
          print("@ 체크기능 꺼져있음 @");
        } else {
          print('@ 체크기능 관련 에러@');
        }
      },
      onLongPress: () {
        if (snapshot.data[whatMMatrix - 1][index].isChecked == 0) viewEisenNote(snapshot.data[whatMMatrix - 1][index]);
      },
    );
  }

  ///containerMaker 는, 아이젠메모 객체 한개를 받아서 실제 메모쪼가리가 담긴 적절한 콘테이너를 리턴해준다.
  Container containerMaker(EisenMemo E, bool checkMode) {
    //초기화
    double checkContainerWidth = 25;
    double textContainerWidth = MediaQuery.of(context).size.width * 0.42 - checkContainerWidth;
    double containerHeight = MediaQuery.of(context).size.height * 0.05;
    double titleSize = 16;
    double contextSize = 12;
    //분기 로직
    int a = 0;
    if (isCheckboxEnabled && E.isChecked == 1)
      a = 1;
    else if (isCheckboxEnabled && E.isChecked == 0 && E.memoContext == "")
      a = 2;
    else if (isCheckboxEnabled && E.isChecked == 0 && E.memoContext != "")
      a = 3;
    switch (a) {
      case 1:
        return Container(
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: checkContainerWidth,
                height: containerHeight,
                child: Icon(CupertinoIcons.checkmark_square_fill),
                alignment: Alignment.center,
              ),
              Container(
                width: textContainerWidth,
                height: titleSize,
                alignment: Alignment.centerLeft,
                child: Text(
                  E.memoTitle,
                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black54, fontSize: titleSize),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
        );
        break;
      case 2:
        return Container(
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: checkContainerWidth,
                height: containerHeight,
                child: Icon(CupertinoIcons.app),
                alignment: Alignment.center,
              ),
              Container(
                width: textContainerWidth,
                height: titleSize,
                alignment: Alignment.centerLeft,
                child: Text(
                  E.memoTitle,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: titleSize),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
        );
        break;
      case 3:
        return Container(
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: checkContainerWidth,
                height: containerHeight,
                child: Icon(CupertinoIcons.app),
                alignment: Alignment.center,
              ),
              Column(
                children: [
                  Container(
                    width: textContainerWidth,
                    height: titleSize,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      E.memoTitle,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: titleSize),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: textContainerWidth,
                    height: contextSize,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      E.memoContext,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: contextSize),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          )),
        );
        ///TODO
    ///4번 5번 로직 만들어야함

      default:
        return Container(child: Text("ERROR"));
    }
  }

  IconSlideAction slideMakerDelete(dynamic snapshot, int index, int whatmatrix) {
    return IconSlideAction(
        color: Colors.red,
        icon: CupertinoIcons.delete_solid,
        onTap: () {
          deleteEisenMemo(snapshot.data[whatmatrix][index].id);
          setState(() {});
        });
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      marginEnd: 5,
      marginBottom: MediaQuery.of(context).size.height * 0.93,
      icon: Icons.settings,
      activeIcon: Icons.remove,
      buttonSize: MediaQuery.of(context).size.height * 0.05,
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
          child: Icon(Icons.widgets_outlined),
          backgroundColor: colorMatcher(0),
          label: '애벌레 메인',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => gotoEisenhowerPage(),
        ),
        SpeedDialChild(
          child: Icon(Icons.book_outlined),
          backgroundColor: colorMatcher(0),
          label: '노트북 목록',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => gotoNoteBookListPage(),
        ),
        SpeedDialChild(
          child: Icon(Icons.note_add_outlined),
          backgroundColor: colorMatcher(0),
          label: '빠른노트 추가',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          labelBackgroundColor: Colors.black,
          onTap: () => gotoQuickNoteAddPage(),
        ),
      ],
    );
  }

  dynamic eggMaker() {
    return showDialog(
        barrierColor: Colors.black54,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(children: [
                    Text(
                      "도움주신분",
                      style: TextStyle(fontSize: 20, color: randomColorMaker(), fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "최혜은",
                      style: TextStyle(fontSize: 15, color: randomColorMaker(), fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "박영준",
                      style: TextStyle(fontSize: 15, color: randomColorMaker(), fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "김민성",
                      style: TextStyle(fontSize: 15, color: randomColorMaker(), fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "김일균",
                      style: TextStyle(fontSize: 15, color: randomColorMaker(), fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "똘이",
                      style: TextStyle(fontSize: 15, color: randomColorMaker(), fontWeight: FontWeight.bold),
                    ),
                  ])));
        });
  }

  gotoNoteBookListPage() {}

  gotoQuickNoteAddPage() {}

  gotoEisenhowerPage() {}

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
        return Colors.black;
      case 5:
        return Colors.white;
    }
    return Colors.green;
  }

  Color randomColorMaker() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
