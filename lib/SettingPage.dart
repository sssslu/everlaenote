import 'package:everlaenote/Eisenhower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'public.dart' as p;

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("설정"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () async {
                    p.isCheckboxEnabled = !p.isCheckboxEnabled;
                    print("체크 상태 변경 :" + (p.isCheckboxEnabled).toString());
                    setState(() {});
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(color: Colors.redAccent.shade200),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '체크박스 켜기',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 10,
                      ),
                      Icon(p.isCheckboxEnabled ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.checkmark_square)
                    ]),
                  )),
              InkWell(
                  onTap: () {
                    alertNotFunctioning(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(color: Colors.deepOrange.shade200),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '애벌레 사용 꿀팁',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  )),
              InkWell(
                  onTap: () {
                    alertNotFunctioning(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(color: Colors.yellow.shade200),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '고급 설정',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  )),
              InkWell(
                  onTap: () {
                    alertNotFunctioning(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(color: Colors.green.shade200),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '똘이에 관하여',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  )),
              InkWell(
                  onTap: () {
                    alertNotFunctioning(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(color: Colors.blue.shade200),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '개발자 도와주기',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  )),
            ])),
            InkWell(
                onTap: () {
                  p.pref.setBool('checkboxenabled', p.isCheckboxEnabled); //글로벌 쉐어드 프리퍼런스에 체크모드 상태 저장
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => EisenhowerPage()), (route) => false);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(color: Colors.black87),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      CupertinoIcons.return_icon,
                      color: Colors.white,
                    ),
                  ]),
                )),
          ],
        ));
  }

  void alertNotFunctioning(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('아직 설계중인 기능',
              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
          content: Text(
            "아직 동작하지 않는 기능입니다. 업데이트를 기다려주세요!",
            style: TextStyle(fontSize: 13, color: Colors.green),
          ),
          actions: <Widget>[
            InkWell(
              child: Text(
                '기다릴게요',
                style: TextStyle(fontSize: 13, color: Colors.blue),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
