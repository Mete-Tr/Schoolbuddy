import 'package:flutter/material.dart';
import 'package:x/widgets/app_drawer.dart';
import 'package:x/widgets/timetable_day.dart';

class TimetableScreen extends StatefulWidget {
  static const routhName = '/timetable';
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Timetable'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: <Widget>[
            TimetableDay('Mo'),
            TimetableDay('Di'),
            TimetableDay('Mi'),
            TimetableDay('Do'),
            TimetableDay('Fr'),
          ],
        ),
      ),
    );
  }
}
