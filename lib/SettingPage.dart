import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globalsDAO.dart' as globalsDAO;

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("설정"),
      ),
      body: Center(
          child: Column(children: [
        RaisedButton(
          onPressed: () {
            print("지원하지 않는 기능");
            setState(() {
            });
          },
          child: Text('다크모드 활성/비활성'),
        ),
        RaisedButton(
          onPressed: () {
            globalsDAO.checkChange();
          },
          child: Text('체크박스 활성/비활성'),
        ),
        RaisedButton(
          onPressed: () {
            globalsDAO.langChange();
            setState(() {
            });
          },
          child: Text('English/한국어'),
        ),
        Container(height: MediaQuery.of(context).size.height*0.1,),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => EisenhowerPage()),(route) => false);
          },
          child: Text('확인'),
        ),
      ])),
    );
  }
}
