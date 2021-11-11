class NoteBook {
  //노트북 종류
  int id; //primary key (순서구분용)
  String noteBookTitle;
  String noteBookBrief;
  int noteBookColor;

  ///id INTEGER PRIMARY KEY AUTOINCREMENT, uid INTEGER AUTOINCREMENT,  notebooktitle TEXT NOT NULL, notebookbrief TEXT NOT NULL, notebookcolor INTEGER NOT NULL

  NoteBook(
    int id,
    String noteBookTitle,
    String noteBookBrief,
    int noteBookColor,
  ) {
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

class NoteNormal {
  ///노트북 안에 들어있는 노트
  int id;
  int noteOwnerID;
  String noteTitle;
  String noteContext;

  NoteNormal(int id, int noteOwnerID, String noteTitle, int noteType, String noteContext) {
    this.id = id;
    this.noteOwnerID = noteOwnerID;
    this.noteTitle = noteTitle;
    this.noteContext = noteContext;
  }

  NoteNormal.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.noteOwnerID = map['noteownerid'];
    this.noteTitle = map['notetitle'];
    this.noteContext = map['notecontext'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noteownerid': noteOwnerID,
      'notetitle': noteTitle,
      'notecontext': noteContext,
    };
  }
}

class NoteChecklist {
  int id;
  int noteOwnerID;
  String noteTitle;

  NoteChecklist(int id, int noteOwnerID, String noteTitle) {
    this.id = id;
    this.noteOwnerID = noteOwnerID;
    this.noteTitle = noteTitle;
  }

  NoteChecklist.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.noteOwnerID = map['noteownerid'];
    this.noteTitle = map['notetitle'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noteownerid': noteOwnerID,
      'notetitle': noteTitle,
    };
  }
}

class ObjNoteChecklist {
  int id;
  int objOwnerId;
  String objTitle;
  String objContext;
  int objChecked;


  ObjNoteChecklist(int id, int objOwnerId, String objTitle, String objContext,int objChecked) {
    this.id = id;
    this.objOwnerId = objOwnerId;
    this.objTitle = objTitle;
    this.objContext = objContext;
    this.objChecked = objChecked;
  }

  ObjNoteChecklist.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.objOwnerId = map['objOwnerId'];
    this.objTitle = map['objTitle'];
    this.objContext = map['objContext'];
    this.objChecked = map['objChecked'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'objOwnerId': objOwnerId,
      'objTitle': objTitle,
      'objContext': objContext,
      'objChecked': objChecked,
    };
  }
}
