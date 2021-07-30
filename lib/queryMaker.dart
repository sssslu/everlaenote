import 'package:everlaenote/Eisenhower.dart';
import 'package:everlaenote/dbConnector.dart';
import 'package:everlaenote/model/checkboxMemo.dart';
import 'model/note.dart';
import 'model/notebook.dart';

class QueryMaker {
  Future<List<CheckboxMemo>> queryForEisen(int caseNum) async {
    ///case  : checkbox memo for UI INU NIU NINU
    List<CheckboxMemo> wholeEisenCheckboxMemo = [];
    List<CheckboxMemo> case1list = [];
    List<CheckboxMemo> case2list = [];
    List<CheckboxMemo> case3list = [];
    List<CheckboxMemo> case4list = [];
    print('디비커넥터 생성시작');
    dbConnector d = new dbConnector();
    print('디비커넥터 생성끝');
    final dummy1 = CheckboxMemo(0, 'title', 'context', 3, 0);
    await d.insertCheckboxMemo(dummy1);
    print('인서트완료됨');
    wholeEisenCheckboxMemo = await d.getAllTheCheckboxMemo();
    
    for (CheckboxMemo i in wholeEisenCheckboxMemo) {//sorting part
      if (i.whatMatrix == 1) {
        case1list.add(i);
      }
      if (i.whatMatrix == 2) {
        case2list.add(i);
      }
      if (i.whatMatrix == 3) {
        case3list.add(i);
      }
      if (i.whatMatrix == 4) {
        case4list.add(i);
      } else {
        print("error occurred. matrix number is" + caseNum.toString());
      }
    }
    switch (caseNum) {
      case 1:
        if (case1list.toString() != "[]")
          print("case 1 !! returning data for query");
        return case1list;
        break;
      case 2:
        if (case2list.toString() != "[]")
          print("case 2 !! returning data for query");
        return case2list;
        break;
      case 3:
        if (case3list.toString() != "[]")
          print("case 3 !! returning data for query");
        return case3list;
        break;
      case 4:
        if (case4list.toString() != "[]")
          print("case 4 !! returning data for query");
        return case4list;
        break;
    }
  }

  List<Notebook> queryForNoteBookList() {
    return null;
  }

  List<Note> queryForNoteList(String noteBookName) {
    return null;
  }
}
