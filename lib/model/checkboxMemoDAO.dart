import 'checkboxMemo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
        print("테이블 생성 시작");
        await db.execute(
          "CREATE TABLE checkboxmemo(id INTEGER PRIMARY KEY AUTOINCREMENT, memotitle TEXT NOT NULL, memocontext TEXT NOT NULL, whatmatrix INTEGER NOT NULL, ischecked INTEGER NOT NULL)",
        );
        print("테이블 생성됨");
      },
    );
  }
  Future<bool> insertCheckboxMemo() async{
    final db = await database;
    await db.rawInsert('insert into checkboxmemo(memotitle, memocontext, whatmatrix, ischecked) values("aaaaa", "annnnnnnnnnnnnnnnggggggggggg",1,0)');//dummy
    return true;
  }

  ///method converting MAP of checkboxmemo to checkboxmemo
  Future<List<CheckboxMemo>> getEveryCheckboxMemoFromDB() async {
    final db = await database;
    List<Map<String,dynamic>> mapList = await db.query("checkboxmemo");
    List<CheckboxMemo> cbmList =[];
    for(Map<String,dynamic>map in mapList){
      cbmList.add(CheckboxMemo.fromMap(map));
    }
    print(cbmList.toString());
    return cbmList;
  }
}
