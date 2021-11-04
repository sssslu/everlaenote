import 'noteObjects.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// 노 관련 DB 조작 클래스
class NoteObjectsDAO {
  static Database _database1;
  static Database _database2;

  Future<Database> get database1 async {
    if (_database1 != null) return _database1;
    _database1 = await initDB1();
    return _database1;
  }
  Future<Database> get database2 async {
    if (_database2 != null) return _database2;
    _database2 = await initDB2();
    return _database2;
  }

  initDB1() async {
    String path = join(await getDatabasesPath(), 'notebooks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE notebooks(id INTEGER PRIMARY KEY AUTOINCREMENT, uid INTEGER AUTOINCREMENT,  notebooktitle TEXT NOT NULL, notebookbrief TEXT NOT NULL, notebookcolor INTEGER NOT NULL)",
        );
        print("@@@ 신규 테이블 생성되었음 - 노트북 @@@");
      },
    );
  }
  initDB2() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE notebooklist(id INTEGER PRIMARY KEY AUTOINCREMENT, notetitle TEXT NOT NULL, notetype INTEGER NOT NULL, noteowneruid INTEGER NOT NULL, notecontext TEXT NOT NULL)",
        );
        print("@@@ 신규 테이블 생성되었음 - 노트 @@@");
      },
    );
  }

  Future<bool> insertNoteBook(String notebooktitle,String notebookbrief ,int notebookcolor) async {
    final db = await database1;
    await db.rawInsert('insert into notebooks(notebooktitle, notebookbrief, notebookcolor) values("$notebooktitle", "$notebookbrief",$notebookcolor)');
    return true;
  }

  Future<List<NoteBook>> getAllNoteBooksFromDB() async {
    final db = await database1;
    /*List<Map<String, dynamic>> mapList = await db.query("eisenmemo");
    List<EisenMemo> cbmList = [];
    for (Map<String, dynamic> map in mapList) {
      cbmList.add(EisenMemo.fromMap(map));
    }
    for(EisenMemo m in cbmList) {
      print(m.toMap());
    }
    return cbmList;*/
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
