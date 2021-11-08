import 'package:flutter/material.dart';

import 'noteObjects.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// 노 관련 DB 조작 클래스
class NoteObjectsDAO {
  static Database _database;

  Future<Database> get database async {
    if (_database != null){
      print("디비 널아님, 디비 그냥 리턴함");
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'notebooks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
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
  Future<bool> insertNoteBook(String notebooktitle, String notebookbrief, int notebookcolor) async {
    final db = await database;
    print(await db.rawInsert('insert into notebooks(notebooktitle, notebookbrief, notebookcolor) values("$notebooktitle", "$notebookbrief",$notebookcolor)'));
    return true;
  }

  Future<List<NoteBook>> getAllNoteBooksFromDB() async {
    final db = await database;
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
    final db = await database;
    await db.rawDelete('DELETE FROM notes WHERE notebooktitle="$noteBookTitle"');
  }

  Future<void> deleteNoteBookFromDB(NoteBook notebook) async {
    final db = await database;
    String ownerName = notebook.noteBookTitle;
    deleteEveryNotesInSpecificNoteBook(ownerName);
    await db.rawDelete('DELETE FROM notebook WHERE notebooktitle = "$ownerName"');
  }

  Future<void> noteBookColorChange(String title, int color) async {
    final db = await database;
    await db.rawUpdate('UPDATE notebooks SET notebookcolor=$color WHERE notebooktitle = "$title"');
  }

  Future<void> updateNoteInDB(int noteid, String title, String context) async {
    final db = await database;
    await db.rawUpdate('UPDATE notes SET notetitle="$title", notecontext="$context" WHERE id=$noteid');
  }

  Future<void> switchNoteBookIDFromDB(int targetId, int myId) async {
    final db = await database;

    ///분기 로직은 그림2 참고
    print("id-$myId와 id-$targetId 스위치");
    await db.rawUpdate('UPDATE notebooks SET id=-1 WHERE id=$myId');
    await db.rawUpdate('UPDATE notebooks SET id=-2 WHERE id=$targetId');
    await db.rawUpdate('UPDATE notebooks SET id="$myId" WHERE id=-2');
    await db.rawUpdate('UPDATE notebooks SET id="$targetId" WHERE id=-1');
    return 1;
  }
}
