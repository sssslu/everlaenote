import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

bool isCheckboxEnabled;
SharedPreferences pref;

Color colorMatcher(int w) {
  switch (w) {
    case 0:
      return Colors.black87;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.green;
    case 3:
      return Colors.redAccent;
    case 4:
      return Colors.amber;
    case 5:
      return Colors.white;
    case 6:
      return Colors.deepPurple.shade900;
    case 10:
      return Colors.red.shade200;
    case 11:
      return Colors.orange.shade200;
    case 12:
      return Colors.amber.shade200;
    case 13:
      return Colors.lightGreenAccent.shade200;
    case 14:
      return Colors.green.shade200;
    case 15:
      return Colors.lightBlue.shade200;
    case 16:
      return Colors.blue.shade200;
    case 17:
      return Colors.purple.shade200;
    case 18:
      return Colors.blueGrey.shade200;
    case 20:
      return Colors.red.shade800;
    case 21:
      return Colors.orange.shade900;
    case 22:
      return Colors.amber.shade500;
    case 23:
      return Colors.green.shade900;
    case 24:
      return Colors.blue.shade900;
    case 25:
      return Colors.purple.shade900;
  }
  return Colors.black;
}

void alertNotFunctioning(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('아직 설계중인 기능', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
        content: Text(
          "아직 동작하지 않는 기능입니다. 업데이트를 기다려주세요!",
          style: TextStyle(fontSize: 13, color: Colors.green),
        ),
        actions: <Widget>[
          InkWell(
            child: Text(
              '기다릴게요',
              style: TextStyle(fontSize: 13, color: Colors.blue),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

class PublicDAO {
  static Database _database;

  Future<Database> get database async {
    print("*** GET DB ***");
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    print("*** INIT DATABASE ***");
    String path = join(await getDatabasesPath(), 'everlae.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print("*** NEW DB CREATING ***");
        await db.execute(
          "CREATE TABLE eisenmemo(id INTEGER PRIMARY KEY AUTOINCREMENT, memotitle TEXT NOT NULL, memocontext TEXT NOT NULL, whatmatrix INTEGER NOT NULL, ischecked INTEGER NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE notebooks(id INTEGER PRIMARY KEY AUTOINCREMENT,  notebooktitle TEXT NOT NULL, notebookbrief TEXT NOT NULL, notebookcolor INTEGER NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE notenormal(id INTEGER PRIMARY KEY AUTOINCREMENT, noteownerid INTEGER NOT NULL, notetitle TEXT NOT NULL, notecontext TEXT NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE notechecklist(id INTEGER PRIMARY KEY AUTOINCREMENT, noteownerid INTEGER NOT NULL, notetitle TEXT NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE objnotechecklist(id INTEGER PRIMARY KEY AUTOINCREMENT, objownerid INTEGER NOT NULL, objtitle TEXT NOT NULL, objcontext TEXT NOT NULL, objchecked INTEGER NOT NULL)",
        );
      },
    );
  }
}
