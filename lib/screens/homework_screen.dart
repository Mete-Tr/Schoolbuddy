import 'package:flutter/material.dart';
import 'package:x/widgets/app_drawer.dart';

import 'new_HM_screen.dart';

class Homework extends StatefulWidget {
  static const routhName = '/homeworks';
  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Hausaufgaben'),
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {
            Navigator.of(context).pushNamed(NewHMScreen.routhName);
          })
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Mach deine Hausaufgaben!'),
      ),
    );
  }
}
