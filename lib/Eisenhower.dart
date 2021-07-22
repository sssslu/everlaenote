import 'package:everlaenote/queryMaker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/checkboxMemo.dart';

List<CheckboxMemo> IUlist;
List<CheckboxMemo> INUlist;
List<CheckboxMemo> NIUlist;
List<CheckboxMemo> NINUlist;

class ImportantUrgent {
  void fullThisList() {
    QueryMaker q = new QueryMaker();
    IUlist = q.queryForEisen(1);
  }
}

class ImportantNotUrgent {
  void fullThisList() {
    QueryMaker q = new QueryMaker();
    INUlist = q.queryForEisen(2);
  }
}

class NotImportantUrgent {
  void fullThisList() {
    QueryMaker q = new QueryMaker();
    NIUlist = q.queryForEisen(3);
  }
}

class NotImportantNotUrgent {
  void fullThisList() {
    QueryMaker q = new QueryMaker();
    NINUlist = q.queryForEisen(4);
  }
}

class EisenhowerPage extends StatefulWidget {
  EisenhowerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EisenhowerPageState createState() => _EisenhowerPageState();
}

class _EisenhowerPageState extends State<EisenhowerPage> {
  int _counter = 0;

  goToNoteSimpleAddPage() {
    setState(() {
      print("Note 작성 페이지로 이동");
    });
    return true;
  }

  showSidebar() {
    print("showing sidebar");
  }

  goToSettingPage() {
    print("setting page 로 이동");
  }

  getAllEisenhowerCheckboxMemo() {
    ImportantUrgent a = new ImportantUrgent();
    a.fullThisList();
    ImportantNotUrgent b = new ImportantNotUrgent();
    b.fullThisList();
    NotImportantUrgent c = new NotImportantUrgent();
    c.fullThisList();
    NotImportantNotUrgent d = new NotImportantNotUrgent();
    d.fullThisList();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getAllEisenhowerCheckboxMemo();

    List<String> iu;//일단 iu 의 제목들만 출력 확인
    for(CheckboxMemo i in IUlist){
      iu.add(i.noteTitle + "\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/ //empty appbar 로 바꿀 예정
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              FloatingActionButton(
                onPressed: showSidebar,
                tooltip: 'side menu',
                child: Icon(Icons.menu),
              ),
              Container(
                width: 5,
              ),
              Container(
                width: 5,
              ),
              Container(
                width: 5,
              ),
              Text(
                'everlae note',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 5,
              ),
              Container(
                width: 5,
              ),
              Container(
                width: 5,
              ), //need to find a better way

              FloatingActionButton(
                onPressed: goToSettingPage,
                tooltip: 'setting',
                child: Icon(Icons.settings),
              ),
            ]),
            Text("iu : "),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToNoteSimpleAddPage,
        tooltip: 'add note',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
