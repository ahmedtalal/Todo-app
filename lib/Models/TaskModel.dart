class TaskModel {
  int _id;
  String _title ;
  String _priority ;
  DateTime _date ;
  int _status ;

  TaskModel(dynamic obj){
    _id = obj["id"];
    _title = obj["title"] ;
    _priority = obj["priority"] ;
    _date = obj["date"];
    _status = obj["status"] ;
  }

  TaskModel.fromMap(Map<String,dynamic> data){
    _id = data["id"];
    _title = data["title"] ;
    _priority = data["priority"] ;
    _date = DateTime.parse(data["date"]);
    _status = data["status"] ;
  }

  Map<String , dynamic> toMap() => {
    "id" : _id ,
    "title" : _title ,
    "priority" : _priority ,
    "date" : _date.toIso8601String() ,
    "status" : _status ,
  };

  int get id => _id ;

  String get title => _title ;

  String get priority => _priority ;

  DateTime get date => _date ;

  int get status => _status ; 
}