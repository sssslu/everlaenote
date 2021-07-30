import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Eisenhower.dart';
import 'package:everlaenote/model/checkboxMemo.dart';

class dbConnector {
  Future<bool> getCMDB() async {
    cmdatabase = await openDatabase(
      join(await getDatabasesPath(), 'checkboxmemo_database.db'),
      onCreate: (db, version) {
        print("db for checkboxmemo created");
        return db.execute(
          'CREATE TABLE checkboxmemo(id INTEGER PRIMARY KEY, memotitle TEXT, memocontext TEXT, whatmatrix INTEGER, ischecked INTEGER)',
        );
      },
      version: 1,
    );
    print("db path is : " + await getDatabasesPath());
    return true;
  }

  Future<List<CheckboxMemo>> getAllTheCheckboxMemo() async {
    List<Map<dynamic, dynamic>> maps = await cmdatabase.query('checkboxmemo');
    return List.generate(maps.length, (i) {
      return CheckboxMemo(
        int.parse(maps[i]['id']),
        maps[i]['memotitle'],
        maps[i]['memocontext'],
        int.parse(maps[i]['whatmatrix']),
        int.parse(maps[i]['ischecked'],
        )
      );
    });
  }

  Future<void> insertCheckboxMemo(CheckboxMemo checkboxMemo) async{
    await cmdatabase.insert('checkboxmemo', checkboxMemo.toMap());
  }
}
