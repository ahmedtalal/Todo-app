import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Models/TaskModel.dart';

class TasksDbBuiler {
  static TasksDbBuiler _dbBuilder ;
  static Database _db ;
  static const String _DATA_BASE_NAME = "Todo.db" ;
  static const String _TABLE_NAME = "tasks" ;
  static const String CREATE_TABLE_SQL = "create table tasks(id integer primary key autoincrement,title text,priority text,date text,status integer)";



  // this method is used to create only one instance from this class 
  static TasksDbBuiler getInstance(){
    if (_dbBuilder == null) {
      _dbBuilder = TasksDbBuiler() ;
    }
    return _dbBuilder ;
  }

  // create database >>>
  Future<Database> _createDB() async{
    if (_db != null) {
      return _db ;
    }
    String path = join(await getDatabasesPath() , _DATA_BASE_NAME) ;
     _db = await openDatabase(path , version: 1 , onCreate: (db , version){
       db.execute(CREATE_TABLE_SQL) ;
     });
     return _db ;
  }

  // insertion mehtod >>
  Future<int> insertTaskInDB(TaskModel task) async{
    Database db = await _createDB() ;
    return db.insert(_TABLE_NAME, task.toMap());
  }


  // retrieve all tasks from db >>>
  Future<List<TaskModel>> retrieveAllData() async {
    Database db = await _createDB() ;
    List<Map<String , dynamic>> map = await db.query(_TABLE_NAME) ;
    List<TaskModel> list = List() ;
    map.forEach((element) { 
      TaskModel task = TaskModel.fromMap(element) ;
      list.add(task);
    });
    list.sort((taskA,taskB) => taskA.date.compareTo(taskB.date)) ; // to sort list
    return list ;
  }

  
  // updata task method >>>
  Future<int> updataTask(TaskModel task) async{
    Database db = await _createDB() ;
    return db.update(_TABLE_NAME, task.toMap(),where: "id=?",whereArgs: [task.id]);
  }

  // delete task from db >>>
  Future<int> deleteTask(int id) async{
    Database db = await _createDB() ;
    return db.delete(_TABLE_NAME , where: "id=?",whereArgs: [id]);
  }
}