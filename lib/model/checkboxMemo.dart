
class CheckboxMemo{
  int id = 0;
  String memoTitle = "";
  String memoContexts = "";
  int whatMatrix = 0;
  int isChecked = 0;//sqflite doesn't support boolean. so 0=false 1=true i assigned.

  CheckboxMemo(int uid,String a,String b,int c,int d){
    this.id = uid;
    this.memoTitle = a;
    this.memoContexts = b;
    this.whatMatrix = c;
    this.isChecked = d;
  }

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'memoTitle':memoTitle,
      'memoContexts':memoContexts,
      'whatMatrix': whatMatrix,
      'isChecked':isChecked,
    };
  }
}