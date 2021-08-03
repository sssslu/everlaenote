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
  List<CheckboxMemo> wholeList;
  List<CheckboxMemo> IUlist;
  List<CheckboxMemo> INUlist;
  List<CheckboxMemo> NIUlist;
  List<CheckboxMemo> NINUlist;
  int _counter = 0;

  goToNoteSimpleAddPage() async{
    print("Note 작성 페이지로 이동");
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    cmd.insertCheckboxMemo();///putting dummy in
    setState(() {});
  }

  showSidebar() {
    print("showing sidebar");
  }

  goToSettingPage() {
    print("setting page 로 이동");
  }

  getAllCheckboxMemo() async {
    print("getAllCheckboxMemo 실행");
    wholeList = [];
    IUlist = [];
    INUlist = [];
    NIUlist = [];
    NINUlist = [];
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    wholeList=await cmd.getEveryCheckboxMemoFromDB();
    ///method filling 4 lists (iu inu niu ninu)
    ///
    ///
    return true;
  }

  @override
  initState() {
    print('이닛스테이트');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(height: MediaQuery.of(context).size.height*0.03,
              child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FloatingActionButton(
              onPressed: showSidebar,
              tooltip: 'side menu',
              child: Icon(Icons.menu),
            ),
            Text(
              "everlae note",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
                                  height: MediaQuery.of(context).size.height *
                                          0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                        const Divider(),
                                    padding: EdgeInsets.all(8),
                                    itemCount: IUlist.length,
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
                                                    IUlist[index].memoTitle,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(IUlist[index]
                                                      .memoContexts)
                                                ]),
                                          ]));
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
                                  height: MediaQuery.of(context).size.height *
                                          0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                        const Divider(),
                                    padding: EdgeInsets.all(8),
                                    itemCount: INUlist.length,
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
                                                    INUlist[index].memoTitle,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(INUlist[index]
                                                      .memoContexts)
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
                                  height: MediaQuery.of(context).size.height *
                                      0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                    const Divider(),
                                    padding: EdgeInsets.all(8),
                                    itemCount: NIUlist.length,
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
                                                    NIUlist[index].memoTitle,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Text(NIUlist[index]
                                                      .memoContexts)
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
                                  height: MediaQuery.of(context).size.height *
                                      0.42,
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext b, int i) =>
                                    const Divider(),
                                    padding: EdgeInsets.all(8),
                                    itemCount: NINUlist.length,
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
                                                    NINUlist[index].memoTitle,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Text(NINUlist[index]
                                                      .memoContexts)
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
