import 'eisenMemo.dart';
import 'package:everlaenote/public.dart' as p;

/// 체크박스메모(아이젠아워 페이지) 관련 DB 조작 클래스
class EisenMemoDAO {
  p.PublicDAO pbd = new p.PublicDAO();

  Future<bool> insertEisenMemo(String memotitle, String memocontext, int whatmatrix) async {
    final db = await pbd.database;
    await db.rawInsert('insert into eisenmemo(memotitle, memocontext, whatmatrix, ischecked) values("$memotitle", "$memocontext",$whatmatrix,0)');
    return true;
  }

  Future<List<EisenMemo>> getEveryEisenMemoFromDB() async {
    final db = await pbd.database;
    List<Map<String, dynamic>> mapList = await db.query("eisenmemo");
    List<EisenMemo> cbmList = [];
    for (Map<String, dynamic> map in mapList) {
      cbmList.add(EisenMemo.fromMap(map));
    }
    for (EisenMemo m in cbmList) {
      print(m.toMap());
    }
    return cbmList;
  }

  Future<void> deleteEveryEisenMemoInSpecificList(int whatmatrix) async {
    final db = await pbd.database;
    await db.rawDelete('DELETE FROM eisenmemo WHERE whatmatrix=$whatmatrix');
  }

  Future<void> deleteEisenMemoFromDB(int id) async {
    final db = await pbd.database;
    await db.rawDelete('DELETE FROM eisenmemo WHERE id = $id');
  }

  Future<void> checkStatusChange(int id, int isChecked) async {
    final db = await pbd.database;
    await db.rawUpdate('UPDATE eisenmemo SET ischecked=$isChecked WHERE id=$id');
  }

  Future<void> updateEisenMemoInDB(int id, String title, String context) async {
    final db = await pbd.database;
    await db.rawUpdate('UPDATE eisenmemo SET memotitle="$title", memocontext="$context" WHERE id=$id');
  }

  Future<void> changeEisenMemoMatrix(int id, int whatMatrix) async {
    final db = await pbd.database;
    await db.rawUpdate('UPDATE eisenmemo SET whatmatrix="$whatMatrix" WHERE id=$id');
    print('matrix change done');
  }

  Future<void> switchEisenMemoFromDB(int targetId, int myId) async {
    final db = await pbd.database;

    ///분기 로직은 그림2 참고
    print("id-$myId와 id-$targetId 스위치");
    await db.rawUpdate('UPDATE eisenmemo SET id=-1 WHERE id=$myId');
    await db.rawUpdate('UPDATE eisenmemo SET id=-2 WHERE id=$targetId');
    await db.rawUpdate('UPDATE eisenmemo SET id="$myId" WHERE id=-2');
    await db.rawUpdate('UPDATE eisenmemo SET id="$targetId" WHERE id=-1');

    return 1;
  }
}
