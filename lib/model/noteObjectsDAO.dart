import 'noteObjects.dart';
import 'package:everlaenote/public.dart' as p;

/// 노 관련 DB 조작 클래스
class NoteObjectsDAO {
  p.PublicDAO pbd = new p.PublicDAO();

  Future<bool> insertNoteBook(String notebooktitle, String notebookbrief, int notebookcolor) async {
    final db = await pbd.database;
    print(await db.rawInsert('insert into notebooks(notebooktitle, notebookbrief, notebookcolor) values("$notebooktitle", "$notebookbrief",$notebookcolor)'));
    return true;
  }

  Future<List<NoteBook>> getAllNoteBooksFromDB() async {
    final db = await pbd.database;
    List<Map<String, dynamic>> mapList = await db.query("notebooks");
    List<NoteBook> noteBookList = [];
    for (Map<String, dynamic> map in mapList) {
      noteBookList.add(NoteBook.fromMap(map));
    }
    for (NoteBook m in noteBookList) {
      print("###"+m.toMap().toString()+"###");
    }
    return noteBookList;
  }
  Future<List<NoteNormal>> getAllNoteNormalsFromDB() async {
    final db = await pbd.database;
    List<Map<String, dynamic>> mapList = await db.query("notenormal");
    List<NoteNormal> noteNormalList = [];
    for (Map<String, dynamic> map in mapList) {
      noteNormalList.add(NoteNormal.fromMap(map));
    }
    for (NoteNormal m in noteNormalList) {
      print("###"+m.toMap().toString()+"###");
    }
    return noteNormalList;
  }
  Future<List<NoteChecklist>> getAllNoteChecklistsFromDB() async {
    final db = await pbd.database;
    List<Map<String, dynamic>> mapList = await db.query("notechecklist");
    List<NoteChecklist> noteChecklistList = [];
    for (Map<String, dynamic> map in mapList) {
      noteChecklistList.add(NoteChecklist.fromMap(map));
    }
    for (NoteChecklist m in noteChecklistList) {
      print("###"+m.toMap().toString()+"###");
    }
    return noteChecklistList;
  }

  Future<void> deleteEveryNotesInSpecificNoteBook(String noteBookTitle) async {
    final db = await pbd.database;
    await db.rawDelete('DELETE FROM notes WHERE noteowner="$noteBookTitle"');
  }

  Future<void> deleteNoteBookFromDB(NoteBook notebook) async {
    final db = await pbd.database;
    String ownerName = notebook.noteBookTitle;
    await deleteEveryNotesInSpecificNoteBook(ownerName);
    await db.rawDelete('DELETE FROM notebooks WHERE notebooktitle = "$ownerName"');
  }

  Future<void> noteBookColorChange(String title, int color) async {
    final db = await pbd.database;
    await db.rawUpdate('UPDATE notebooks SET notebookcolor=$color WHERE notebooktitle = "$title"');
  }

  Future<void> updateNoteBookInDB(int noteid, String title, String context) async {
    final db = await pbd.database;
    await db.rawUpdate('UPDATE notebooks SET notebooktitle="$title", notebookbrief="$context" WHERE id=$noteid');
  }

  Future<void> switchNoteBookIDFromDB(int targetId, int myId) async {
    ///분기 로직은 그림2 참고
    final db = await pbd.database;
    print("id-$myId와 id-$targetId 스위치");
    await db.rawUpdate('UPDATE notebooks SET id=-1 WHERE id=$myId');
    await db.rawUpdate('UPDATE notebooks SET id=-2 WHERE id=$targetId');
    await db.rawUpdate('UPDATE notebooks SET id="$myId" WHERE id=-2');
    await db.rawUpdate('UPDATE notebooks SET id="$targetId" WHERE id=-1');
  }
}
