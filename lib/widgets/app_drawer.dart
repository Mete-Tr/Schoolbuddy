import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/screens/notes_screen.dart';
import 'package:x/screens/profile_screen.dart';
import 'package:x/screens/timetable_screen.dart';
import 'package:x/screens/welcome_screen.dart';

import '../provider/authProv.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Navigator'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Welcome Screen'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(WelcomeScreen.routhName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Screen'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routhName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.table_chart),
            title: Text('Timetable'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(TimetableScreen.routhName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.done),
            title: Text('Homeworks'),
            onTap: () {
              // Navigation...
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Notes'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(NotesScreen.routhName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<AuthProv>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
