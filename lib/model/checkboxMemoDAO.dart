import 'checkboxMemo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// 체크박스메모(아이젠아워 페이지) 관련 DB 조작 클래스 입니다.
/// author slu
class CheckboxMemoDAO {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'checkboxmemo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE checkboxmemo(id INTEGER PRIMARY KEY AUTOINCREMENT, memotitle TEXT NOT NULL, memocontext TEXT NOT NULL, whatmatrix INTEGER NOT NULL, ischecked INTEGER NOT NULL)",
        );
        print("@@@ 신규 테이블 생성되었음 - 체크박스메모 DAO @@@");
      },
    );
  }

  Future<bool> insertCheckboxMemo(int whatmatrix) async {
    final db = await database;
    await db.rawInsert('insert into checkboxmemo(memotitle, memocontext, whatmatrix, ischecked) values("oraora", "roadrollerdaaaaaa",$whatmatrix,0)'); //dummy
    return true;
  }

  Future<List<CheckboxMemo>> getEveryCheckboxMemoFromDB() async {
    final db = await database;
    List<Map<String, dynamic>> mapList = await db.query("checkboxmemo");
    List<CheckboxMemo> cbmList = [];
    for (Map<String, dynamic> map in mapList) {
      cbmList.add(CheckboxMemo.fromMap(map));
    }
    print(cbmList.toString());
    return cbmList;
  }

  Future<void> deleteEveryCheckboxMemoInSpecificList(int whatmatrix) async {
    final db = await database;
    await db.rawDelete('DELETE FROM checkboxmemo WHERE whatmatrix=$whatmatrix');
  }

  Future<void> deleteCheckboxMemoFromDB(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM checkboxmemo WHERE id = $id');
  }

  Future<void> checkStatusChange(int id, int c) async {
    final db = await database;
    await db.rawUpdate('UPDATE checkboxmemo SET ischecked=$c WHERE id=$id');
  }

  Future<void> updateCheckboxMemoInDB(int id, String title, String context) async {
    final db = await database;
    await db.rawUpdate('UPDATE checkboxmemo SET memotitle="$title", memocontext="$context" WHERE id=$id');
    print('update done');
  }
}
