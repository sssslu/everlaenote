import 'eisenMemo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// 체크박스메모(아이젠아워 페이지) 관련 DB 조작 클래스 입니다.
/// author slu
class EisenMemoDAO {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'eisenmemo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE eisenmemo(id INTEGER PRIMARY KEY AUTOINCREMENT, memotitle TEXT NOT NULL, memocontext TEXT NOT NULL, whatmatrix INTEGER NOT NULL, ischecked INTEGER NOT NULL)",
        );
        print("@@@ 신규 테이블 생성되었음 - 체크박스메모 @@@");
      },
    );
  }

  Future<bool> insertEisenMemo(String memotitle,String memocontext ,int whatmatrix) async {
    final db = await database;
    await db.rawInsert('insert into eisenmemo(memotitle, memocontext, whatmatrix, ischecked) values("$memotitle", "$memocontext",$whatmatrix,0)');
    return true;
  }

  Future<List<EisenMemo>> getEveryEisenMemoFromDB() async {
    final db = await database;
    List<Map<String, dynamic>> mapList = await db.query("eisenmemo");
    List<EisenMemo> cbmList = [];
    for (Map<String, dynamic> map in mapList) {
      cbmList.add(EisenMemo.fromMap(map));
    }
    print(cbmList.toString());
    return cbmList;
  }

  Future<void> deleteEveryEisenMemoInSpecificList(int whatmatrix) async {
    final db = await database;
    await db.rawDelete('DELETE FROM eisenmemo WHERE whatmatrix=$whatmatrix');
  }

  Future<void> deleteEisenMemoFromDB(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM eisenmemo WHERE id = $id');
  }

  Future<void> checkStatusChange(int id, int ischecked) async {
    final db = await database;
    await db.rawUpdate('UPDATE eisenmemo SET ischecked=$ischecked WHERE id=$id');
  }

  Future<void> updateEisenMemoInDB(int id, String title, String context) async {
    final db = await database;
    await db.rawUpdate('UPDATE eisenmemo SET memotitle="$title", memocontext="$context" WHERE id=$id');
    print('update done');
  }
}
