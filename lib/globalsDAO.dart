import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart'as g;

SharedPreferences _pref;

checkGetter() async {
  print('@ GLOBALS DAO 체크게터 실행됨 @');
  _pref = await SharedPreferences.getInstance();
  return(_pref.getBool('checkboxEnabled') ?? true);
}

checkChange() async {
  print("체크체인지 실행");
  g.checkmode = !checkGetter();
  _pref.setBool('checkboxenabled', g.checkmode);
  print("DAO 에서 globals 로 체크 상태 던져줌 : " + g.checkmode.toString());
}

langChange() async {}
