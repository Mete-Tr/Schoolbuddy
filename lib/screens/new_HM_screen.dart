import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/provider/homeworkProv.dart';

class NewHMScreen extends StatefulWidget {
  static const routhName = '/NewHA';
  @override
  _NewHMScreenState createState() => _NewHMScreenState();
}

class _NewHMScreenState extends State<NewHMScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final titleController = TextEditingController();
  final taskController = TextEditingController();
  Map data = {'title': '', 'tasks': ''};
  @override
  Widget build(BuildContext context) {
    final hmProv = Provider.of<HomeworkProv>(context);
    final device = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Neue Hausaufgabe'),
      ),
      body: SafeArea(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: device.height,
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Titel', hintText: 'z.B.: Gedicht analysieren'),
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      data['title'] = val;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Aufgaben', hintText: 'z.B.: S. 13 Nr. 5'),
                    controller: taskController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    onChanged: (val) {
                      data['tasks'] = val;
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'Speichern',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      hmProv.addHomework(data['title'], data['tasks'], context);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
