import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/database/moor_database.dart';
import 'package:x/widgets/app_drawer.dart';

class TimetableScreen extends StatefulWidget {
  static const routhName = '/timetable';
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Stundenplan'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
          minimum: EdgeInsets.only(left: 5, right: 5),
          child: Lesson(),
          ),
    );
  }
}

class Lesson extends StatefulWidget {
  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<TimetableDao>(context);
    return StreamBuilder(
      stream: dao.watchAllTimetable(),
      builder: (context, AsyncSnapshot<List<Timetable>> snapshot) {
        return Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (ctx, i) => Container(
                    color: Colors.red,
                    child: Text('$i'),
                  ),
                ),
              ),
            );
      },
    );
  }
}