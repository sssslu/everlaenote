import 'package:everlaenote/dbConnector.dart';
import 'package:everlaenote/queryMaker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'model/checkboxMemo.dart';

Database cmdatabase;///global database

class EisenhowerPage extends StatefulWidget {
  EisenhowerPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _EisenhowerPageState createState() => _EisenhowerPageState();
}

class _EisenhowerPageState extends State<EisenhowerPage> {
  List<CheckboxMemo> IUlist;
  List<CheckboxMemo> INUlist;
  List<CheckboxMemo> NIUlist;
  List<CheckboxMemo> NINUlist;
  int _counter = 0;

  goToNoteSimpleAddPage() {
    print("Note 작성 페이지로 이동");
    return true;
  }

  showSidebar() {
    print("showing sidebar");
  }

  goToSettingPage() {
    print("setting page 로 이동");
  }

  getAllEisenhowerCheckboxMemo() async {
    ///method filling 4 lists (iu inu niu ninu)
    print("getAllEisenhowerCheckboxMemo 실행됨!!");
    QueryMaker q = new QueryMaker();
    IUlist = await q.queryForEisen(1);
    INUlist = await q.queryForEisen(2);
    NIUlist = await q.queryForEisen(3);
    NINUlist = await q.queryForEisen(4);
    return ".";
  }

  @override
  initState() {
    print('이닛스테이트 시작');
    super.initState();
    dbConnector dbc = new dbConnector();
    print('이닛스이트 - 디비커낵터 만듦.');
    dbc.getCMDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          ]),
          FutureBuilder(
              future: getAllEisenhowerCheckboxMemo(),
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
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(color: Colors.green, width: 2),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height * 0.397-45,
                                    child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext b, int i) =>
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
                                      border: Border.all(color: Colors.green, width: 2),
                                    ),
                                  ),
                                ],
                              ),

                            Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.009),
                              width: MediaQuery.of(context).size.width * 0.47,
                              height:
                                  MediaQuery.of(context).size.height * 0.397,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.001,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.358,
                                    child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext b, int i) =>
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.009),
                              width: MediaQuery.of(context).size.width * 0.47,
                              height:
                                  MediaQuery.of(context).size.height * 0.397,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.001,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.358,
                                    child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext b, int i) =>
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.009),
                              width: MediaQuery.of(context).size.width * 0.47,
                              height:
                                  MediaQuery.of(context).size.height * 0.397,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.width *
                                            0.001,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.46,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: MediaQuery.of(context).size.height *
                                        0.358,
                                    child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext b, int i) =>
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
                                    ),
                                  ),
                                ],
                              ),
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
