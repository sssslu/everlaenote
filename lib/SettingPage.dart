import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ///중요한 전역변수들
  SharedPreferences _pref;
  bool isCheckboxEnabled;

  Future<bool> checkGetter() async {
    _pref = await SharedPreferences.getInstance();
    isCheckboxEnabled = (_pref.getBool('checkboxenabled'));
    print("세팅페이지에서 불러온 쉐프의 체크상태 : "+isCheckboxEnabled.toString());
    return isCheckboxEnabled;
  }

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
      body: FutureBuilder(
          future: checkGetter(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            } else
              ///여기서부터 페이지 실제 내용
              return Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RaisedButton(
                    onPressed: () {
                      print("체크 체인지 버튼 눌림!");
                      setState(() {
                        isCheckboxEnabled = !isCheckboxEnabled;
                        _pref.setBool('checkboxenabled', isCheckboxEnabled);
                      });
                    },
                    child: Text('체크박스 모드 활성화 or 비활성화'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      print("메인페이지로!");
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => EisenhowerPage()),(route) => false);
                    },
                    child: Text('확인'),
                  ),
                ]),
              );
            ///여기까지 --------------@@
          })
    );
  }
}
