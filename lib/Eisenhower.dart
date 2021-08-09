import 'package:everlaenote/model/checkboxMemoDAO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'model/checkboxMemo.dart';
import 'package:screen/screen.dart';

CheckboxMemoDAO cmd = new CheckboxMemoDAO();
bool isCheckboxInabled = false;
final TextEditingController _titleController = TextEditingController();

/// 일단 false이긴 한데 사용자 설정에서 가져오게 바꿔야함.

class EisenhowerPage extends StatefulWidget {
  EisenhowerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EisenhowerPageState createState() => _EisenhowerPageState();
}

class _EisenhowerPageState extends State<EisenhowerPage> {

  showSidebar() {
    print("showing sidebar");
  }

  goToSettingPage() {
    print("setting page 로 이동");
    print("체크박스 보이기 상태 변경 실행");
    isCheckboxInabled = !isCheckboxInabled;
    setState(() {});
  }


  Future<List<List<CheckboxMemo>>> getAllCheckboxMemo() async {
    print("get all @@@@@@");
    List<CheckboxMemo> wholeList = [];
    List<CheckboxMemo> IUlist = [];
    List<CheckboxMemo> INUlist = [];
    List<CheckboxMemo> NIUlist = [];
    List<CheckboxMemo> NINUlist = [];
    List<List<CheckboxMemo>> wholeListList = [];
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

  void viewNote(CheckboxMemo c) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("${c.memoTitle}"),
          content: new Text("${c.memoContext}"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Edit"),
              onPressed: () {
                Navigator.pop(context);
                editNote(c);
              },
            ),
            new FlatButton(
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

  void editNote(CheckboxMemo c) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          title: new TextFormField(controller: _titleController,
              decoration: InputDecoration(
                helperText: "제목",
                  labelText: "제목",
                  border: OutlineInputBorder(),
                  hintText: '${c.memoTitle}'),
              validator: (value) {
                if (value.isEmpty) {
                  return '이메일 입력';
                } else
                  return null;
              }),
          content: new Text("${c.memoContext}"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Edit"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(
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

  goToNoteSimpleAddPage() async {
    print("Note 작성 페이지로 이동");

    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    cmd.insertCheckboxMemo();
  }

  void deleteCheckboxMemo(int id) async {
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    cmd.deleteCheckboxMemoFromDB(id);
    print("id number " + id.toString() + "deleted.");
  }

  void deleteEverything(int whatmatrix) async {
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    await cmd.deleteEveryCheckboxMemoInSpecificList(whatmatrix);
    setState(() {});
  }

  void checkCheckboxMemo(int id, int c) async {
    CheckboxMemoDAO cmd = new CheckboxMemoDAO();
    await cmd.checkStatusChange(id, c);
    print("check " + c.toString());
    setState(() {});
  }

  int k = 20;

  ///length of ...
  ///k 와 글자크기는 연관성을 가져야 하며, 화면너비에 종속되어야한다.
  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Screen.keepOn(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.03,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: showSidebar,
                  child: Icon(
                    Icons.menu,
                    color: Colors.green,
                  ),
                ),
                Text(
                  "everlae note",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: goToSettingPage,
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                ),
              ])),
          FutureBuilder(
              future: getAllCheckboxMemo(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                } else
                  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
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
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green, width: 2), color: Colors.white),
                                  child: Center(
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                    Text(
                                      "긴급 & 중요",
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.delete,
                                      size: MediaQuery.of(context).size.width * 0.05,
                                      color: Colors.green,
                                    ),
                                  ]))),
                              onLongPress: () {
                                deleteEverything(1);
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
                                itemCount: snapshot.data[0].length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = snapshot.data[0][index].hashCode.toString();
                                  return Slidable(
                                    child: InkWell(
                                      child: Container(
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.459,
                                          child: Center(
                                              child: Row(children: [
                                            isCheckboxInabled == true
                                                ? Container(
                                                    width: MediaQuery.of(context).size.width * 0.05,
                                                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                    child: Icon(snapshot.data[0][index].isChecked == 0 ? CupertinoIcons.app : CupertinoIcons.checkmark_square_fill),
                                                  )
                                                : Container(width: 4),
                                            snapshot.data[0][index].memoContext != ""
                                                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    Text(
                                                      snapshot.data[0][index].memoTitle,
                                                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      snapshot.data[0][index].memoContext.length > k
                                                          ? snapshot.data[0][index].memoContext.substring(0, k) + ".."
                                                          : snapshot.data[0][index].memoContext,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  ])
                                                : Text(
                                                    snapshot.data[0][index].memoTitle,
                                                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                  ),
                                          ]))),
                                      onTap: () {
                                        isCheckboxInabled == true
                                            ? checkCheckboxMemo(snapshot.data[0][index].id, snapshot.data[0][index].isChecked == 1 ? 0 : 1)
                                            : print("check function not working");
                                      },
                                      onLongPress: () {
                                        viewNote(snapshot.data[0][index]);
                                      },
                                    ),
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.25,
                                    direction: Axis.horizontal,
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                        caption: 'Edit',
                                        color: Colors.black45,
                                        icon: Icons.edit,
                                        onTap: () => editNote(snapshot.data[0][index]),
                                      ),
                                      IconSlideAction(
                                          caption: 'Delete',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () {
                                            deleteCheckboxMemo(snapshot.data[0][index].id);
                                            setState(() {});
                                          }),
                                    ],
                                  );
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
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.005,
                                  MediaQuery.of(context).size.width * 0.005,
                                  MediaQuery.of(context).size.width * 0.005,
                                  MediaQuery.of(context).size.width * 0,
                                ),
                                width: MediaQuery.of(context).size.width * 0.46,
                                height: MediaQuery.of(context).size.height * 0.03,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.blue, width: 2), color: Colors.white),
                                child: Center(
                                  child: Text(
                                    "안긴급 & 중요",
                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.001,
                              ),
                              width: MediaQuery.of(context).size.width * 0.46,
                              height: MediaQuery.of(context).size.height * 0.42,
                              child: ListView.separated(
                                separatorBuilder: (BuildContext b, int i) => const Divider(),
                                padding: EdgeInsets.all(8),
                                itemCount: snapshot.data[1].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width * 0.459,
                                      child: Row(children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                            "INUlist[index].memoTitle",
                                            style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                          Text("@")
                                        ]),
                                      ]));
                                },
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.blue, width: 2),
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
                                width: MediaQuery.of(context).size.width * 0.46,
                                height: MediaQuery.of(context).size.height * 0.03,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.yellow, width: 2), color: Colors.white),
                                child: Center(
                                  child: Text(
                                    "긴급 & 안중요",
                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.001,
                              ),
                              width: MediaQuery.of(context).size.width * 0.46,
                              height: MediaQuery.of(context).size.height * 0.42,
                              child: ListView.separated(
                                separatorBuilder: (BuildContext b, int i) => const Divider(),
                                padding: EdgeInsets.all(8),
                                itemCount: snapshot.data[2].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width * 0.459,
                                      child: Row(children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                            "NIUlist[index].memoTitle",
                                            style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                          Text("NIUlist[index].memoContexts")
                                        ]),
                                      ]));
                                },
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.yellow, width: 2),
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
                                width: MediaQuery.of(context).size.width * 0.46,
                                height: MediaQuery.of(context).size.height * 0.03,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.redAccent, width: 2), color: Colors.white),
                                child: Center(
                                  child: Text(
                                    "안긴급 & 안중요",
                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.width * 0.001,
                              ),
                              width: MediaQuery.of(context).size.width * 0.46,
                              height: MediaQuery.of(context).size.height * 0.42,
                              child: ListView.separated(
                                separatorBuilder: (BuildContext b, int i) => const Divider(),
                                padding: EdgeInsets.all(8),
                                itemCount: snapshot.data[3].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width * 0.459,
                                      child: Row(children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                            "  NINUlist[index].memoTitle",
                                            style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                          Text("NINUlist[index].memoContexts")
                                        ]),
                                      ]));
                                },
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.redAccent, width: 2),
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
        onPressed: () {
          setState(() {});
          goToNoteSimpleAddPage();
        },
        tooltip: 'add note',
        child: Icon(Icons.add),
      ),
    );
  }
}
