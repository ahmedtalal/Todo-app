import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/ConstVar.dart';
import 'package:to_do_app/Models/TaskModel.dart';
import 'package:to_do_app/database/TaskDbBuilder.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  String _title, _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dataController = TextEditingController();
  DateFormat _dateFormat = DateFormat("MM , dd , yyyy");
  final List<String> priorities = ["Low", "Meduim", "High"];

  @override
  void initState() {
    super.initState();
    // this is to add the date by default when this screen is loaded >>>
    _dataController.text = _dateFormat.format(_date);
  }

  // calling this method to dispose controller after dispose this state >>
  @override
  void dispose() {
    super.dispose();
    _dataController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Add Task",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: ConstantVars.yuseiMagic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60.0,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    // title text form field >>>>>
                    TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: ConstantVars.yuseiMagic,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (input) {
                        if (input.isEmpty) {
                          return "title is required";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          // you code is here >>>
                          _title = value;
                        });
                      },
                    ),

                    SizedBox(
                      height: 22.0,
                    ),

                    // data text form field >>>>
                    TextFormField(
                      controller: _dataController,
                      onTap: _handelDataPicker,
                      readOnly: true,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: ConstantVars.yuseiMagic,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: "Date",
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),

                    SizedBox(
                      height: 22.0,
                    ),

                    // priority text form field >>>>>
                    DropdownButtonFormField(
                      isDense: true,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      iconSize: 23.0,
                      items: priorities.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        );
                      }).toList(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: ConstantVars.yuseiMagic,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: "Priority",
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (input) {
                        if (_priority == null) {
                          return "priority is required";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          // you code is here >>>
                          _priority = value;
                        });
                      },
                      value: _priority,
                    ),

                    SizedBox(
                      height: 25.0,
                    ),

                    // add task button inside container  >>>>
                    Container(
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: FlatButton(
                        child: Text(
                          "Add Task",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: ConstantVars.yuseiMagic,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (formKey.currentState.validate()) {
                              // your code is here >>>
                              TaskModel taskModel = TaskModel({
                                "title": _title,
                                "priority": _priority,
                                "date": _date,
                                "status": 0
                              });
                              TasksDbBuiler.getInstance().insertTaskInDB(taskModel);
                              Navigator.of(context).pop(context);
                            }
                          });
                        },
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  // this method is used to handel data >>>>
  _handelDataPicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dataController.text = _dateFormat.format(_date);
    }
  }
}
