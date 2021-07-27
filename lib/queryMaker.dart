import 'package:everlaenote/model/checkboxMemo.dart';
import 'package:flutter/material.dart';
import 'model/note.dart';
import 'model/notebook.dart';

class QueryMaker {
  List<CheckboxMemo> queryForEisen(int caseNum) {
    /////////////////////sqlite 와 연동할 쿼리머신 (일단 쉐어드프리퍼런스사용)
    //case 1 : checkbox memo for UI
    //case 2 : checkbox memo for INU
    //case 3 : checkbox memo for NIU
    //case 4 : checkbox memo for NINU
    //일단 더미데이터 삽입기를 여기 만들기
    CheckboxMemo dummy1 = new CheckboxMemo("A title", "context of a");
    CheckboxMemo dummy2 = new CheckboxMemo("B title", "context of b");
    CheckboxMemo dummy3 = new CheckboxMemo("C title", "context of c");

    List<CheckboxMemo> dumlist1 = [];
    dumlist1.add(dummy1);
    dumlist1.add(dummy2);
    dumlist1.add(dummy3);
    dumlist1.add(dummy3);
    dumlist1.add(dummy3);
    dumlist1.add(dummy3);
    dumlist1.add(dummy3);
    dumlist1.add(dummy3);
    dumlist1.add(dummy3);
    List<CheckboxMemo> dumlist2 = [];
    dumlist2.add(dummy1);
    dumlist2.add(dummy1);
    List<CheckboxMemo> dumlist3 = [];
    dumlist3.add(dummy1);
    dumlist3.add(dummy2);
    dumlist3.add(dummy2);
    dumlist3.add(dummy3);
    List<CheckboxMemo> dumlist4 = [];
    dumlist4.add(dummy1);
    dumlist4.add(dummy2);
    dumlist4.add(dummy3);
    dumlist4.add(dummy3);
    dumlist4.add(dummy3);
    /////////////////////////////////////////////////////////////////////////////////////////////

    switch (caseNum) {
      case 1:
        print("case 1 !! returning dummy data for query");
        return dumlist1;
      case 2:
        print("case 2 !! returning dummy data for query");
        return dumlist2;
      case 3:
        print("case 3 !! returning dummy data for query");
        return dumlist3;
      case 4:
        print("case 4 !! returning dummy data for query");
        return dumlist4;
    }
  }

  List<Notebook> queryForNoteBookList() {
    return null;
  }

  List<Note> queryForNoteList(String noteBookName) {
    return null;
  }
}
