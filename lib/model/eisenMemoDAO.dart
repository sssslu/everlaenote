import 'eisenMemo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:everlaenote/public.dart'as p;

/// 체크박스메모(아이젠아워 페이지) 관련 DB 조작 클래스
class EisenMemoDAO {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print("디비 널아님, 디비 그냥 리턴함");
      p.database = _database;
      return _database;
    }
    _database = await initDB();
    p.database = _database;
    return _database;
  }

  initDB() async {
    print("이닛디비 시작");
    String path = join(await getDatabasesPath(), 'everlae.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print("디비 온크리에이트");
        await db.execute(
          "CREATE TABLE eisenmemo(id INTEGER PRIMARY KEY AUTOINCREMENT, memotitle TEXT NOT NULL, memocontext TEXT NOT NULL, whatmatrix INTEGER NOT NULL, ischecked INTEGER NOT NULL)",
        );
        print("@@@ 신규 테이블 생성되었음 - 아이젠메모 @@@");
        await db.execute(
          "CREATE TABLE notebooks(id INTEGER PRIMARY KEY AUTOINCREMENT,  notebooktitle TEXT NOT NULL, notebookbrief TEXT NOT NULL, notebookcolor INTEGER NOT NULL)",
        );
        print("@@@ 신규 테이블 생성 - 노트북들 @@@");
        await db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, notetitle TEXT NOT NULL, notetype INTEGER NOT NULL, noteowner STRING NOT NULL, notecontext TEXT NOT NULL)",
        );
        print("@@@ 신규 테이블 생성 - 노트들 @@@");
      },
    );
  }

  Future<bool> insertEisenMemo(String memotitle,String memocontext ,int whatmatrix) async {
    print("인서트 아이젠메모 시작. database 호출함.");
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
    for(EisenMemo m in cbmList) {
      print(m.toMap());
    }
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

  Future<void> checkStatusChange(int id, int isChecked) async {
    final db = await database;
    await db.rawUpdate('UPDATE eisenmemo SET ischecked=$isChecked WHERE id=$id');
  }

  Future<void> updateEisenMemoInDB(int id, String title, String context) async {
    final db = await database;
    await db.rawUpdate('UPDATE eisenmemo SET memotitle="$title", memocontext="$context" WHERE id=$id');
  }

  Future<void> changeEisenMemoMatrix(int id, int whatMatrix) async {
    final db = await database;
    await db.rawUpdate('UPDATE eisenmemo SET whatmatrix="$whatMatrix" WHERE id=$id');
    print('matrix change done');
  }

  Future<void> switchEisenMemoFromDB(int targetId, int myId) async {
    final db = await database;
    ///분기 로직은 그림2 참고
    print("id-$myId와 id-$targetId 스위치");
    await db.rawUpdate('UPDATE eisenmemo SET id=-1 WHERE id=$myId');
    await db.rawUpdate('UPDATE eisenmemo SET id=-2 WHERE id=$targetId');
    await db.rawUpdate('UPDATE eisenmemo SET id="$myId" WHERE id=-2');
    await db.rawUpdate('UPDATE eisenmemo SET id="$targetId" WHERE id=-1');

    return 1;
  }
}
