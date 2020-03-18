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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Stundenplan'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
          minimum: EdgeInsets.only(left: 5, right: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    day('Montag'),
                    day('Dienstag'),
                    day('Mittwoch'),
                    day('Donnerstag'),
                    day('Freitag'),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                Expanded(
                  child: Lesson(),
                )
              ],
            ),
          )),
    );
  }

  Padding day(String day) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8,
        child: Container(
          height: 65,
          width: 65,
          child: Center(
            child: Text(
              day,
              style: TextStyle(fontSize: 12.5),
            ),
          ),
        ),
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
        final list = snapshot.data ?? List();
        return Padding(
          padding: EdgeInsets.all(5),
          child: GridView.builder(
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (ctx, i) => list[i].isCancelled == true
                  ? Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color(
                        int.parse(list[i].color),
                      ),
                      child: Center(
                        child: Text(list[i].massage),
                      ),
                    )
                  : Card(
                      color: Color(
                        int.parse(list[i].color),
                      ),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(list[i].subjectAcronym),
                          Text(
                            'Raum: ' + list[i].room,
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    )),
        );
      },
    );
  }
}
