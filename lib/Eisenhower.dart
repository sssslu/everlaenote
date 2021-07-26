import 'package:everlaenote/queryMaker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/checkboxMemo.dart';

List<CheckboxMemo> IUlist;
List<CheckboxMemo> INUlist;
List<CheckboxMemo> NIUlist;
List<CheckboxMemo> NINUlist;

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
    /// put method filling 4 lists (iu inu niu ninu)
    print("getAECB 실행됨!!!!!!!!");
    QueryMaker q = new QueryMaker();
    IUlist = await q.queryForEisen(1);
    INUlist = await q.queryForEisen(2);
    NIUlist = await q.queryForEisen(3);
    NINUlist = await q.queryForEisen(4);
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

          ///put some checkboxmemo retriveing method and widgets here
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
                                color: Colors.deepPurple,
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
                                        color: Colors.deepPurple.shade700,
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
