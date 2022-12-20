import 'package:flutter/material.dart';
import 'package:flutter_hive/models/task.dart';
import 'package:hive/hive.dart';

import '../../config/colors.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/dropdown_widget.dart';
import '../../widgets/input_text.dart';

class TaskForm extends StatefulWidget {
  final int id;
  final String nameChange;

  TaskForm({Key key, this.id, this.nameChange}) : super(key: key);
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final taskForm = GlobalKey<FormState>();
  String name;
  String urgency;

  void submitData() {
    final index = widget.id;
    if (index == null) {
      if (taskForm.currentState.validate()) {
        Box<Task> todoBox = Hive.box<Task>('tasks');
        todoBox.add(Task(
            name: name,
            urgency: urgency,
            isComplete: false,
            createdAt: DateTime.now()));

        Navigator.pushNamed(context, '/');
      }
    } else {
      if (taskForm.currentState.validate()) {
        final index = widget.id;
        Task task =
            Task(name: name, urgency: urgency, createdAt: DateTime.now());
        Box<Task> todoBox = Hive.box<Task>('tasks');
        todoBox.put(index, task);
        Navigator.of(context).pop();
      }
    }
  }

  List<Map<String, dynamic>> noteLevel = [
    {"name": "Home"},
    {"name": "Job"},
  ];
  List<Map<String, dynamic>> noteLevel2 = [
    {"name": "Urgency"},
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      noteLevel.addAll(noteLevel2);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          widgetAction: SizedBox(),
          automaticallyImplyLeading: true,
          title: widget.id == null ? "Create task" : widget.nameChange,
        ),
        body: Center(
          child: Container(
            width: size.width * 0.95,
            height: size.height * 0.95,
            padding: EdgeInsets.all(5),
            child: Form(
                key: taskForm,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      name: name,
                      validator: (v) {
                        if (v.isEmpty) {
                          return "Field can not be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropDownWidget(
                      hint: urgency == null
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'Select option',
                                style: TextStyle(
                                    fontSize: 18, color: ColorsTheme.textColor),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                urgency,
                                style: TextStyle(color: ColorsTheme.textColor),
                              ),
                            ),
                      dropdownItens: noteLevel.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val["name"],
                            child:
                                Container(width: 100, child: Text(val["name"])),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            urgency = val;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        onPressed: submitData,
                        child: widget.id == null
                            ? Text(
                                "Create note",
                                style: Theme.of(context).textTheme.headline4,
                              )
                            : Text(
                                "Update note",
                                style: Theme.of(context).textTheme.headline4,
                              )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
