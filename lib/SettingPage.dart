import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SharedPreferences _pref;
  bool isCheckboxEnabled = true;

  Future<bool> checkGetter() async {
    print('체크게터 실행!');
    _pref = await SharedPreferences.getInstance();
    isCheckboxEnabled = (_pref.getBool('checkboxEnabled') ?? true);
    return isCheckboxEnabled;
  }

  checkChange() async {
    setState(() {
      print("체크체인지 실행");
      isCheckboxEnabled = !isCheckboxEnabled;
      _pref.setBool('checkboxenabled', isCheckboxEnabled);
    });
    print("체크켜짐 : "+isCheckboxEnabled.toString());
  }

  @override
  void initState() {
    super.initState();
    checkGetter();
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
              },
              child: Text('다크모드 활성/비활성'),
            ),
            RaisedButton(
              onPressed: () {
                checkChange();
              },
              child: Text('체크박스 활성/비활성'),
            ), RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('닫기'),
        ),
      ])),
    );
  }
}
