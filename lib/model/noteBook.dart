class NoteBook { //노트북 종류
  int id;
  String noteBookTitle;
  String noteBookBrief;
  int noteBookColor;
}
class Note{ //노트북 안에 들어있는 노트
  int id;
  String noteTitle;
  int noteType;
  String noteOwnerNotebookTitle;//해당 노트를 소유한 노트북의 제목
  String noteContent1;//type 1
  List<NoteListObj> noteContent2;//type 2
}
class NoteListObj{
  int id;
  String noteListObjTitle;
  String noteListObjContext;
  int noteListObjColor;
  String noteListObjOwnerNoteTitle;//해당 노트를 소유한 타입2 노트의 제목
}
//이안에 있는 모든 스트링은 검색이 가능해야함.