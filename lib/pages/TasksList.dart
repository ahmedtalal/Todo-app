import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/ConstVar.dart';
import 'package:to_do_app/Models/TaskModel.dart';
import 'package:to_do_app/database/TaskDbBuilder.dart';
import 'package:to_do_app/pages/AddTask.dart';
import 'package:to_do_app/pages/Setttings.dart';
import 'package:to_do_app/pages/TaskDetails.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  TasksDbBuiler _builder;
  List<TaskModel> _taskList = List();
  DateFormat _dateFormat = DateFormat("MM , dd , yyyy");
  int completeTask;
  @override
  void initState() {
    _builder = TasksDbBuiler.getInstance();
    getAllTasks();
    super.initState();
  }

  getAllTasks() {
    _builder.retrieveAllData().then(
      (value) {
        setState(() {
          _taskList = value;
        });
      },
    );
    // return the number of the completing status
    completeTask = _taskList
        .where((TaskModel taskModel) => taskModel.status == 1)
        .toList()
        .length;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    getAllTasks();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
        onPressed: () {
          // adding task implementation is here >>>>
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddTask(),
          ));
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.13,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Tasks",
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: ConstantVars.yuseiMagic,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Theme.of(context).primaryColor,
                        size: 25,
                      ),
                      onPressed: () {
                        // switch to setting page >>>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Settings()));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "$completeTask of ${_taskList.length}",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: ConstantVars.yuseiMagic,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: bodyBuilder(context, height, width),
          ),
        ],
      ),
    );
  }

  // build widget to body
  Widget bodyBuilder(context, height, width) {
    if (_taskList.length != 0) {
      return ListView.builder(
        itemCount: _taskList.length,
        itemBuilder: (context, index) {
          return tasksBuilder(_taskList[index]);
        },
      );
    } else {
      return Center(
        child: Container(
          height: height * 0.45,
          child: Column(
            children: [
              Container(
                height: height * 0.32,
                child: Image(
                  image: AssetImage("assets/images/nodata.png"),
                ),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              Text(
                "No tasks at this time",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: ConstantVars.yuseiMagic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // build widget to tasks
  Widget tasksBuilder(TaskModel task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            "${task.title}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ConstantVars.yuseiMagic,
              fontSize: 18.0,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            "${_dateFormat.format(task.date)} - ${task.priority}",
            style: TextStyle(
              fontFamily: ConstantVars.yuseiMagic,
              fontWeight: FontWeight.bold,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          trailing: Checkbox(
            value: task.status == 0 ? false : true,
            onChanged: (result) {
              // your code is here >>>
              setState(() {
                if (task.status == 0) {
                  TaskModel taskModel = TaskModel({
                    "id": task.id,
                    "title": task.title,
                    "priority": task.priority,
                    "date": task.date,
                    "status": 1
                  });
                  _builder.updataTask(taskModel);
                } else {
                  TaskModel taskModel = TaskModel({
                    "id": task.id,
                    "title": task.title,
                    "priority": task.priority,
                    "date": task.date,
                    "status": 0
                  });
                  _builder.updataTask(taskModel);
                }
              });
            },
            activeColor: Theme.of(context).primaryColor,
            hoverColor: Theme.of(context).primaryColor,
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TaskDetails(task)));
          },
        ),
      ),
    );
  }
}
