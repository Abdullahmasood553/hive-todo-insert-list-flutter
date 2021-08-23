import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_prod/client/hive_names.dart';
import 'package:hive_prod/models/todo.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  late String task;
  late String note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: true,
                    initialValue: '',
                    decoration: InputDecoration(labelText: 'Task'),
                    onChanged: (value) {
                      setState(() {
                        task = value;
                      });
                    },
                    validator: (val) {
                      return val!.trim().isEmpty
                          ? 'Task name should not be empty'
                          : null;
                    },
                  ),
                  TextFormField(
                    initialValue: '',
                    decoration: const InputDecoration(
                      labelText: 'Note',
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          note = value == null ? '' : value;
                        },
                      );
                    },
                  ),
                  OutlineButton(onPressed: _validateAndSave, child: Text('Add'),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
    void _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      _onFormSubmit();
    } else {
      print('form is invalid');
    }
  }

    void _onFormSubmit() {
    Box<Todo> contactsBox = Hive.box<Todo>(HiveBoxes.todo);
    contactsBox.add(Todo(task: task, note: note));
    Navigator.of(context).pop();
  }
}


