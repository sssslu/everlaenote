class NoteBook { //노트북 종류
  int id;//primary key (순서구분용)
  int uid;//노트 분류 쿼리용 키
  String noteBookTitle;
  String noteBookBrief;
  int noteBookColor;
  ///id INTEGER PRIMARY KEY AUTOINCREMENT, uid INTEGER AUTOINCREMENT,  notebooktitle TEXT NOT NULL, notebookbrief TEXT NOT NULL, notebookcolor INTEGER NOT NULL
}
class Note{ //노트북 안에 들어있는 노트
  int id;
  String noteTitle;
  int noteType;
  int noteOwnerUID;//해당 노트를 소유한 노트북의 제목
  String noteContext1;//type 1
  //List<NoteListObj> noteContent2;//type 2 , 추후 기능 추가
}
/*class NoteListObj{
  int id;
  String noteListObjTitle;
  String noteListObjContext;
  int noteListObjColor;
  String noteListObjOwnerNoteTitle;//해당 노트를 소유한 타입2 노트의 제목
}*/