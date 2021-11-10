class NoteBook {
  //노트북 종류
  int id; //primary key (순서구분용)
  String noteBookTitle;
  String noteBookBrief;
  int noteBookColor;
  ///id INTEGER PRIMARY KEY AUTOINCREMENT, uid INTEGER AUTOINCREMENT,  notebooktitle TEXT NOT NULL, notebookbrief TEXT NOT NULL, notebookcolor INTEGER NOT NULL


  NoteBook(int id, String noteBookTitle, String noteBookBrief, int noteBookColor,) {
    this.id = id;
    this.noteBookTitle = noteBookTitle;
    this.noteBookBrief = noteBookBrief;
    this.noteBookColor = noteBookColor;

  }


  NoteBook.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.noteBookTitle = map['notebooktitle'];
    this.noteBookBrief = map['notebookbrief'];
    this.noteBookColor = map['notebookcolor'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noteBookTitle': noteBookTitle,
      'noteBookBrief': noteBookBrief,
      'noteBookColor': noteBookColor,
    };
  }

}

class Note {
  ///노트북 안에 들어있는 노트
  int id;
  String noteTitle;
  int noteType;
  int noteOwnerUID; //해당 노트를 소유한 노트북의 제목
  String noteContext1; //type 1
//List<NoteListObj> noteContent2;//type 2 , 추후 기능 추가
}