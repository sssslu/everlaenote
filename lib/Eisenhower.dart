import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/checkboxMemo.dart';

class ImportantUrgent {
  List<CheckboxMemo> IUlist;
}

class ImportantNotUrgent {
  List<CheckboxMemo> INUlist;
}

class NotImportantUrgent {
  List<CheckboxMemo> NIUlist;
}

class NotImportantNotUrgent {
  List<CheckboxMemo> NINUlist;
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
      print("basic notebook note 작성 페이지로 이동");
    });
    return true;
  }

  showSidebar() {
    print("showing sidebar");
  }

  goToSettingPage() {
    print("setting page 로 이동");
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
                tooltip: 'Increment',
                child: Icon(Icons.menu),
              ),
              Text(
                'everlae note',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              FloatingActionButton(
                onPressed: goToSettingPage,
                tooltip: 'Increment',
                child: Icon(Icons.settings),
              ),
            ]),
            Text(
              "Eisenhower page"
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToNoteSimpleAddPage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
