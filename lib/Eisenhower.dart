import 'package:everlaenote/queryMaker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/checkboxMemo.dart';

List<CheckboxMemo> IUlist;
List<CheckboxMemo> INUlist;
List<CheckboxMemo> NIUlist;
List<CheckboxMemo> NINUlist;
List<String> IUTitleList = [];
List<String> INUTitleList = [];
List<String> NIUTitleList = [];
List<String> NINUTitleList = [];

class EisenhowerPage extends StatefulWidget {
  EisenhowerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EisenhowerPageState createState() => _EisenhowerPageState();
}

class _EisenhowerPageState extends State<EisenhowerPage> {
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
    print("getAECB 실행됨!!");
    QueryMaker q = new QueryMaker();
    IUlist = await q.queryForEisen(1);
    INUlist = await q.queryForEisen(2);
    NIUlist = await q.queryForEisen(3);
    NINUlist = await q.queryForEisen(4);
    ///to remove hot reload bug, resetting Lists.
    IUTitleList=[];
    INUTitleList=[];
    NIUTitleList=[];
    NINUTitleList=[];
    ///method filling arrays of Strings only with their titles.
    for(CheckboxMemo i in IUlist){
      IUTitleList.add(i.noteTitle);
    }
    for(CheckboxMemo i in INUlist){
      INUTitleList.add(i.noteTitle);
    }
    for(CheckboxMemo i in NIUlist){
      NIUTitleList.add(i.noteTitle);
    }
    for(CheckboxMemo i in NINUlist){
      NINUTitleList.add(i.noteTitle);
    }
    return "getAllEisenhowerCheckboxMemo Done!";
  }

  @override
  initState() {
    super.initState();
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
                            Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.009),
                              width: MediaQuery.of(context).size.width * 0.48,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.green,
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
                                          color: Colors.green.shade700),
                                      child: Center(
                                        child: Text(
                                          "Important & Urgent",
                                          style: TextStyle(
                                              color: Colors.white,
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
                                    child : Text(IUTitleList.toString()),
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
                              width: MediaQuery.of(context).size.width * 0.48,
                              height: MediaQuery.of(context).size.height * 0.4,
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
                                          color: Colors.blue.shade700),
                                      child: Center(
                                        child: Text(
                                          "Important & Not Urgent",
                                          style: TextStyle(
                                              color: Colors.white,
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
                              width: MediaQuery.of(context).size.width * 0.48,
                              height: MediaQuery.of(context).size.height * 0.4,
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
                                          color: Colors.yellow.shade700),
                                      child: Center(
                                        child: Text(
                                          "Not Important & Urgent",
                                          style: TextStyle(
                                              color: Colors.white,
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
                              width: MediaQuery.of(context).size.width * 0.48,
                              height: MediaQuery.of(context).size.height * 0.4,
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
                                        color: Colors.redAccent.shade700,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Not Important & Not Urgent",
                                          style: TextStyle(
                                              color: Colors.white,
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
