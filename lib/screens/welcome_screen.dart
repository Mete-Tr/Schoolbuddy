import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../widgets/app_drawer.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class WelcomeScreen extends StatefulWidget {
  static const routhName = '/welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('onMessage called: $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('onResume called: $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('onLaunch called: $message');
      },
    );
    firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Subject> data = [];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('WelcomeScreen'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: <Widget>[
            Container(
              height: 270,
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Clock'),
                          Icon(
                            Icons.trip_origin,
                            size: 30,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: data.isEmpty
                    ? Center(
                        child: Text(
                          'Noch keine Daten vorhanden',
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Card(
                              // color: data[i].color,
                              // margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                              // child: ListTile(
                              //   leading: Text('${data[i].shortcut}'),
                              //   title: Text('Lehrer: ${data[i].teacher}'),
                              //   trailing: Text('Raum: ${data[i].room}'),
                              // ),
                              );
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
