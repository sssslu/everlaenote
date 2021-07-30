import 'package:everlaenote/model/checkboxMemo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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


    final database = openDatabase(///--------------------------------------------------------------------------------------------------------------------------------//
      join(await getDatabasesPath(),'checkboxmemo_database.db'),
      onCreate: (db, version){
        print("db 생성됨");
        return db.execute('CREATE TABLE checkboxmemo(id INTEGER PRIMARY KEY, memotitle TEXT, memocontext TEXT, whatmatrix INTEGER, ischecked INTEGER)',);
      },
      version: 1,
    );
    //더미데이터 삽입(실제로 넣는 부분 만들기 전까지만 사용)

    //전체 디비 쿼리

    /// 여기서 디비 생성 (또는 연결) 하고, 체크박스 디비를 전부 쿼리하여 wholeEisenCheckboxMemo 리스트에 넣음.-------------------------------------------------------------//



    for (CheckboxMemo i in wholeEisenCheckboxMemo) {
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
