import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x/database/moor_database.dart';
import 'package:x/provider/profileProv.dart';
import 'package:x/widgets/custom_listitem.dart';
import '../models/subject.dart';
import '../widgets/app_drawer.dart';

class WelcomeScreen extends StatefulWidget {
  static const routhName = '/welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<TimetableDao>(context);
    List<Subject> data = [];

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
              height: 250,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: FutureBuilder(
                  future: Provider.of<ProfileProv>(context).getUserData(),
                  builder: (context, snapshot) {
                    SharedPreferences prefs = snapshot.data;
                    if (snapshot?.hasData ?? false) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Hallo, ' +
                              prefs.getString('firstname') +
                              ' ' +
                              prefs.getString('lastname'),
                          style: TextStyle(fontSize: 23),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
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
                    stream: dao.watchTimetableDay(today == 1
                        ? 'MO'
                        : today == 2
                            ? 'DI'
                            : today == 3
                                ? 'MIT'
                                : today == 4
                                    ? 'DO'
                                    : today == 5 ? 'FRI' : 'MO'),
                    builder:
                        (context, AsyncSnapshot<List<Timetable>> snapshot) {
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
                    },
                  )
                  //  data.isEmpty
                  //     ? Center(
                  //         child: Text(
                  //           'Noch keine Daten vorhanden',
                  //         ),
                  //       )
                  //     : ListView.builder(
                  //         itemCount: data.length,
                  //         itemBuilder: (BuildContext context, int i) {
                  //           return Card(

                  //               );
                  //         },
                  //       ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
