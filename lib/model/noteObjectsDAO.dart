import 'package:flutter/material.dart';

import 'noteObjects.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:everlaenote/public.dart' as p;

/// 노 관련 DB 조작 클래스
class NoteObjectsDAO {
  Database db = p.database;


  Future<bool> insertNoteBook(String notebooktitle, String notebookbrief, int notebookcolor) async {
    print(await db.rawInsert('insert into notebooks(notebooktitle, notebookbrief, notebookcolor) values("$notebooktitle", "$notebookbrief",$notebookcolor)'));
    return true;
  }

  Future<List<NoteBook>> getAllNoteBooksFromDB() async {
    List<Map<String, dynamic>> mapList = await db.query("notebooks");
    List<NoteBook> noteBookList = [];
    for (Map<String, dynamic> map in mapList) {
      noteBookList.add(NoteBook.fromMap(map));
    }
    for (NoteBook m in noteBookList) {
      print("###\n");
      print(m.toMap());
    }
    return noteBookList;
  }

  Future<void> deleteEveryNotesInSpecificNoteBook(String noteBookTitle) async {
    await db.rawDelete('DELETE FROM notes WHERE noteowner="$noteBookTitle"');
  }

  Future<void> deleteNoteBookFromDB(NoteBook notebook) async {
    String ownerName = notebook.noteBookTitle;
    await deleteEveryNotesInSpecificNoteBook(ownerName);
    await db.rawDelete('DELETE FROM notebooks WHERE notebooktitle = "$ownerName"');
  }

  Future<void> noteBookColorChange(String title, int color) async {
    await db.rawUpdate('UPDATE notebooks SET notebookcolor=$color WHERE notebooktitle = "$title"');
  }

  Future<void> updateNoteInDB(int noteid, String title, String context) async {
    await db.rawUpdate('UPDATE notes SET notetitle="$title", notecontext="$context" WHERE id=$noteid');
  }

  Future<void> switchNoteBookIDFromDB(int targetId, int myId) async {

    ///분기 로직은 그림2 참고
    print("id-$myId와 id-$targetId 스위치");
    await db.rawUpdate('UPDATE notebooks SET id=-1 WHERE id=$myId');
    await db.rawUpdate('UPDATE notebooks SET id=-2 WHERE id=$targetId');
    await db.rawUpdate('UPDATE notebooks SET id="$myId" WHERE id=-2');
    await db.rawUpdate('UPDATE notebooks SET id="$targetId" WHERE id=-1');
    return 1;
  }
}
