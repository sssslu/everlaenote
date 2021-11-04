class EisenMemo {
  int id;
  String memoTitle;
  String memoContext;
  int whatMatrix;
  int isChecked;

  EisenMemo(int id, String memoTitle, String memoContexts, int whatMatrix,
      int isChecked) {
    this.id = id;
    this.memoTitle = memoTitle;
    this.memoContext = memoContexts;
    this.whatMatrix = whatMatrix;
    this.isChecked = isChecked;
  }

  EisenMemo.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.memoTitle = map['memotitle'];
    this.memoContext = map['memocontext'];
    this.whatMatrix = map['whatmatrix'];
    this.isChecked = map['ischecked'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memoTitle': memoTitle,
      'memoContexts': memoContext,
      'whatMatrix': whatMatrix,
      'isChecked': isChecked,
    };
  }

}


