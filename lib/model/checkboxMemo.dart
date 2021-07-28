class CheckboxMemo{
  String memoTitle = "";
  String memoContexts = "";
  int whatMatrix = 0;
  int isChecked = 0;//sqflite doesn't support boolean. so 0=false 1=true i assigned.

  CheckboxMemo(String a,String b,int c){
    this.memoTitle = a;
    this.memoContexts = b;
    this.whatMatrix = c;
  }
}

//https://flutter.dev/docs/cookbook/persistence/sqlite
//여기서 해당 클래스에 toMap 함수 추가하는것, 그리고 화면 부분에서 db 인서트하는것 생각해보고 작성.