import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x/database/moor_database.dart';
import '../widgets/app_drawer.dart';

class WelcomeScreen extends StatefulWidget {
  static const routhName = '/welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final timeDao = Provider.of<TimetableDao>(context);
    final hmDao = Provider.of<HomeworkDataDao>(context);

    int today = DateTime.now().weekday;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Willkommen'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8,
                child: StreamBuilder(
                  stream: hmDao.watchDoneHomeworks(),
                  builder:
                      (context, AsyncSnapshot<List<HomeworkData>> snapshot) {
                    if (snapshot?.hasData ?? false) {
                      final list = snapshot.data ?? List();
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Willkommen bei Schoolbuddy :)',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Du hast ${list.length} ungemachte Hausaufgaben.',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: StreamBuilder(
                  stream: timeDao.watchTimetableDay(today == 1
                      ? 'MO'
                      : today == 2
                          ? 'DI'
                          : today == 3
                              ? 'MIT'
                              : today == 4 ? 'DO' : today == 5 ? 'FRI' : 'MO'),
                  builder: (context, AsyncSnapshot<List<Timetable>> snapshot) {
                    if (snapshot?.hasData ?? false) {
                      final list = snapshot.data ?? List();
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (ctx, i) {
                          return Card(
                            color: Color(int.parse(list[i].color)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 8,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('${i + 1}.',
                                      style: TextStyle(fontSize: 26)),
                                  Text('${list[i].subjectAcronym}',
                                      style: TextStyle(fontSize: 30)),
                                  Text('${list[i].room}',
                                      style: TextStyle(fontSize: 26))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
