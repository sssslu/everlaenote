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
      return Colors.red.shade600;
    case 11:
      return Colors.orange.shade700;
    case 12:
      return Colors.amber.shade300;
    case 13:
      return Colors.green.shade700;
    case 14:
      return Colors.blue.shade900;
    case 15:
      return Colors.purple.shade800;
  }
  return Colors.black;
}

class PublicDAO {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print("디비 널아님, 디비 그냥 리턴함");
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
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, notetitle TEXT NOT NULL, notetype INTEGER NOT NULL, noteowner STRING NOT NULL, notecontext TEXT NOT NULL)",
        );
      },
    );
  }
}
