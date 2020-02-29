import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/screens/homework_screen.dart';
import 'package:x/screens/notes_screen.dart';
import 'package:x/screens/profile_screen.dart';
import 'package:x/screens/timetable_screen.dart';
import 'package:x/screens/welcome_screen.dart';

import '../provider/authProv.dart';

class AppDrawer extends StatelessWidget with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Navigation'),
              automaticallyImplyLeading: false,
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Willkommen'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(WelcomeScreen.routhName);
                },
              ),
            ),
            Divider(height: 5),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Dein Profil'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ProfileScreen.routhName);
                },
              ),
            ),
            Divider(height: 5),
            Card(
              child: ListTile(
                leading: Icon(Icons.table_chart),
                title: Text('Stundenplan'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(TimetableScreen.routhName);
                },
              ),
            ),
            Divider(height: 5),
            Card(
              child: ListTile(
                leading: Icon(Icons.done),
                title: Text('Hausaufgaben'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Homework.routhName);
                },
              ),
            ),
            Divider(height: 5),
            Card(
              child: ListTile(
                leading: Icon(Icons.note),
                title: Text('Notizen'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(NotesScreen.routhName);
                },
              ),
            ),
            Divider(height: 5),
            Card(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Ausloggen'),
                onTap: () {
                  Provider.of<AuthProv>(context).logout();
                  notifyListeners();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
