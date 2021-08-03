class CheckboxMemo {
  int id = -1;
  String memoTitle = "";
  String memoContexts = "";
  int whatMatrix = 0;
  int isChecked = 0;

  CheckboxMemo(int uid, String memoTitle, String memoContexts, int whatMatrix,
      int isChecked) {
    this.id = uid;
    this.memoTitle = memoTitle;
    this.memoContexts = memoContexts;
    this.whatMatrix = whatMatrix;
    this.isChecked = isChecked;
  }
  CheckboxMemo.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.memoTitle = map['memotitle'];
    this.memoContexts = map['memocontexts'];
    this.whatMatrix = map['whatmatrix'];
    this.isChecked = map['ischecked'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memoTitle': memoTitle,
      'memoContexts': memoContexts,
      'whatMatrix': whatMatrix,
      'isChecked': isChecked,
    };
  }

}


