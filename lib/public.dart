import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

Database database;
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
      return Colors.deepPurple;
    case 10:
      return Colors.red;
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
}
