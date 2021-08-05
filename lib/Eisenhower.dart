import 'package:everlaenote/model/checkboxMemoDAO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'model/checkboxMemo.dart';

Database cmdatabase;

///global database

class EisenhowerPage extends StatefulWidget {
  EisenhowerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EisenhowerPageState createState() => _EisenhowerPageState();
}

class _EisenhowerPageState extends State<EisenhowerPage> {
  goToNoteSimpleAddPage() async {
    print("Note 작성 페이지로 이동");
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    cmd.insertCheckboxMemo();

    ///putting dummy in
    setState(() {});
  }

  showSidebar() {
    print("showing sidebar");
  }

  goToSettingPage() {
    print("setting page 로 이동");
    setState(() {});
  }

  Future<List<List<CheckboxMemo>>> getAllCheckboxMemo() async {
    List<CheckboxMemo> wholeList = [];
    List<CheckboxMemo> IUlist = [];
    List<CheckboxMemo> INUlist = [];
    List<CheckboxMemo> NIUlist = [];
    List<CheckboxMemo> NINUlist = [];
    List<List<CheckboxMemo>> wholeListList = [];
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    wholeList = await cmd.getEveryCheckboxMemoFromDB();
    for (CheckboxMemo i in wholeList) {
      if (i.whatMatrix == 1) {
        IUlist.add(i);
      }
      if (i.whatMatrix == 2) {
        INUlist.add(i);
      }
      if (i.whatMatrix == 3) {
        NIUlist.add(i);
      }
      if (i.whatMatrix == 4) {
        NINUlist.add(i);
      }
    }
    wholeListList.add(IUlist);
    wholeListList.add(INUlist);
    wholeListList.add(NIUlist);
    wholeListList.add(NINUlist);
    print("returning future builder snap");
    return wholeListList;
  }

  void deleteCheckboxMemo(int id) async {
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    await cmd.deleteCheckboxMemoFromDB(id);
    print("id number " + id.toString() + "deleted.");
    setState(() {});
  }

  void checkCheckboxMemo(int id) async {}

  int k = 18;

  ///length of ...
  ///k 와 글자크기는 연관성을 가져야 하며, 화면너비에 종속되어야한다.
  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.03,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      onPressed: showSidebar,
                      tooltip: 'side menu',
                      child: Icon(Icons.menu),
                    ),
                    Text(
                      "everlae note",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton(
                      onPressed: goToSettingPage,
                      tooltip: 'setting',
                      child: Icon(Icons.settings),
                    ),
                  ])),
          FutureBuilder(
              future: getAllCheckboxMemo(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                } else
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.green, width: 2),
                                        color: Colors.white),
                                    child: Center(
                                      child: Text(
                                        "긴급 & 중요",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.001,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  height:
                                      MediaQuery.of(context).size.height * 0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                        const Divider(
                                      color: Colors.green,
                                    ),
                                    padding: EdgeInsets.all(4),
                                    itemCount: snapshot.data[0].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Dismissible(
                                        key: UniqueKey(),
                                        child: InkWell(
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.459,
                                              child: Row(children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 4, 0),
                                                  child: Icon(snapshot
                                                              .data[0][index]
                                                              .isChecked ==
                                                          0
                                                      ? CupertinoIcons.app
                                                      : CupertinoIcons
                                                          .checkmark_square_fill),
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data[0][index]
                                                            .memoTitle,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        snapshot
                                                                    .data[0]
                                                                        [index]
                                                                    .memoContext
                                                                    .length >
                                                                k
                                                            ? snapshot
                                                                    .data[0]
                                                                        [index]
                                                                    .memoContext
                                                                    .substring(
                                                                        0, k) +
                                                                ".."
                                                            : snapshot
                                                                .data[0][index]
                                                                .memoContext,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ]),
                                              ])),
                                          onTap: () {
                                            print("체크!");
                                          },
                                          onLongPress: () {
                                            print(
                                                snapshot.data[0][index].title +
                                                    '의 수정모드로 전환');
                                          },
                                        ),
                                        onDismissed: (direction) {
                                          deleteCheckboxMemo(
                                              snapshot.data[0][index].id);
                                          List<CheckboxMemo> tmp =
                                              snapshot.data[0];
                                          tmp.removeAt(index);
                                          snapshot.data[0] = tmp;

                                          ///not to cause dismissible widget error
                                        },
                                        background: Container(
                                            child: Center(
                                                child: Text(
                                              "CLEAR!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            color: Colors.red),
                                      );
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.green, width: 2),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.blue, width: 2),
                                        color: Colors.white),
                                    child: Center(
                                      child: Text(
                                        "안긴급 & 중요",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.001,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  height:
                                      MediaQuery.of(context).size.height * 0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                        const Divider(),
                                    padding: EdgeInsets.all(8),
                                    itemCount: snapshot.data[1].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.459,
                                          child: Row(children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    " INUlist[index].memoTitle",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text("@")
                                                ]),
                                          ]));
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.blue, width: 2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.yellow, width: 2),
                                        color: Colors.white),
                                    child: Center(
                                      child: Text(
                                        "긴급 & 안중요",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.001,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  height:
                                      MediaQuery.of(context).size.height * 0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                        const Divider(),
                                    padding: EdgeInsets.all(8),
                                    itemCount: snapshot.data[2].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.459,
                                          child: Row(children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "NIUlist[index].memoTitle",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      "NIUlist[index].memoContexts")
                                                ]),
                                          ]));
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.yellow, width: 2),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.width * 0,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.redAccent, width: 2),
                                        color: Colors.white),
                                    child: Center(
                                      child: Text(
                                        "안긴급 & 안중요",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.005,
                                    MediaQuery.of(context).size.width * 0.001,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  height:
                                      MediaQuery.of(context).size.height * 0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                        const Divider(),
                                    padding: EdgeInsets.all(8),
                                    itemCount: snapshot.data[3].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.459,
                                          child: Row(children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "  NINUlist[index].memoTitle",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      "NINUlist[index].memoContexts")
                                                ]),
                                          ]));
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.redAccent, width: 2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]);
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToNoteSimpleAddPage,
        tooltip: 'add note',
        child: Icon(Icons.add),
      ),
    );
  }
}
