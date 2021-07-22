import 'package:everlaenote/model/checkboxMemo.dart';
import 'package:flutter/material.dart';
import 'model/note.dart';
import 'model/notebook.dart';

class QueryMaker {
  List<CheckboxMemo> queryForEisen(int caseNum) {/////////////////////sqlite 와 연동할 쿼리머신 (일단 쉐어드프리퍼런스사용)
    //case 1 : checkbox memo for UI
    //case 2 : checkbox memo for INU
    //case 3 : checkbox memo for NIU
    //case 4 : checkbox memo for NINU
    //일단 더미데이터 삽입기를 여기 만들기
    CheckboxMemo dummy1 = new CheckboxMemo("dummytitle", "asdfa");
    List<CheckboxMemo> dumlist = [dummy1];
    switch (caseNum) {
      case 1:
        print("case 1 !!! returning dummy data for query");
        return dumlist;
    }
  }////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  List<Notebook> queryForNoteBookList() {
    return null;
  }

  List<Note> queryForNoteList(String noteBookName) {
    return null;
  }
}