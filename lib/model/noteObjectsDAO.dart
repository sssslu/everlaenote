import 'noteObjects.dart';
import 'package:everlaenote/public.dart' as p;

/// 노 관련 DB 조작 클래스
class NoteObjectsDAO {
  p.PublicDAO pbd = new p.PublicDAO();

  Future<bool> insertNoteBook(String notebooktitle, String notebookbrief, int notebookcolor) async {
    final db = await pbd.database;
    await db.rawInsert('insert into notebooks(notebooktitle, notebookbrief, notebookcolor) values("$notebooktitle", "$notebookbrief",$notebookcolor)');
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
  Future<List<NoteNormal>> getAllNoteNormalsFromDB(int ownerId) async {
    final db = await pbd.database;
    List<Map<String, dynamic>> mapList = await db.rawQuery("SELECT * FROM notenormal WHERE noteownerid=$ownerId");
    List<NoteNormal> noteNormalList = [];
    for (Map<String, dynamic> map in mapList) {
      noteNormalList.add(NoteNormal.fromMap(map));
    }
    for (NoteNormal m in noteNormalList) {
      print("###"+m.toMap().toString()+"###");
    }
    return noteNormalList;
  }
  Future<List<NoteChecklist>> getAllNoteChecklistsFromDB(int ownerId) async {
    final db = await pbd.database;
    List<Map<String, dynamic>> mapList = await db.rawQuery("SELECT * FROM notechecklist WHERE noteownerid=$ownerId");
    List<NoteChecklist> noteChecklistList = [];
    for (Map<String, dynamic> map in mapList) {
      noteChecklistList.add(NoteChecklist.fromMap(map));
    }
    for (NoteChecklist m in noteChecklistList) {
      print("###"+m.toMap().toString()+"###");
    }
    return noteChecklistList;
  }

  Future<void> deleteEveryNotesInSpecificNoteBook(NoteBook notebook) async {
    final db = await pbd.database;
    await db.rawDelete('DELETE FROM notenormal WHERE noteownerid=${notebook.id}');
    await db.rawDelete('DELETE FROM notechecklist WHERE noteownerid=${notebook.id}');
  }

  Future<void> deleteNoteBookFromDB(NoteBook notebook) async {
    final db = await pbd.database;
    String title = notebook.noteBookTitle;
    await deleteEveryNotesInSpecificNoteBook(notebook);
    await db.rawDelete('DELETE FROM notebooks WHERE notebooktitle = "$title"');
  }

  Future<void> noteBookColorChange(String title, int color) async {
    final db = await pbd.database;
    await db.rawUpdate('UPDATE notebooks SET notebookcolor=$color WHERE notebooktitle = "$title"');
  }

  Future<void> updateNoteBook(int noteid, String title, String context) async {
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

  Future<void> newNote(int ownerID, String title, String context) async {
    final db = await pbd.database;
    await db.rawInsert('insert into notenormal(noteownerid, notetitle, notecontext) values("$ownerID", "$title","$context")');
  }
}
