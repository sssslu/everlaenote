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
        await db.execute(
          "CREATE TABLE checkboxmemo(id INTEGER PRIMARY KEY AUTOINCREMENT, memotitle TEXT NOT NULL, memocontext TEXT NOT NULL, whatmatrix INTEGER NOT NULL, ischecked INTEGER NOT NULL)",
        );
        print("테이블 생성 완료");
      },
    );
  }

  ///method converting MAP of checkboxmemo to checkboxmemo
  Future<List<CheckboxMemo>> getEveryCheckboxMemoFromDB() async {}
}
