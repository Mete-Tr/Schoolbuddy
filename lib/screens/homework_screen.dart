import 'package:flutter/material.dart';
import 'package:x/widgets/app_drawer.dart';

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
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Mach deine Hausaufgaben!'),
      ),
    );
  }
}
