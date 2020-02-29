import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/database/moor_database.dart';
import 'package:x/provider/homeProv.dart';
import 'package:x/provider/profileProv.dart';
import 'package:x/screens/change_email.dart';
import 'package:x/screens/change_password.dart';
import 'package:x/screens/homework_screen.dart';
import 'package:x/screens/new_note_screen.dart';
import 'package:x/screens/profile_screen.dart';
import 'package:x/screens/setup_screen.dart';
import 'package:x/screens/timetable_screen.dart';

import './provider/authProv.dart';
import './provider/notesProv.dart';
import './screens/notes_screen.dart';
import './screens/auth_screen.dart';
import './screens/welcome_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProv(),
        ),
        ChangeNotifierProvider.value(
          value: NotesProv(),
        ),
        ChangeNotifierProvider.value(
          value: AppDatabase().noteDao,
        ),
        ChangeNotifierProvider.value(
          value: ProfileProv(),
        ),
        ChangeNotifierProvider.value(
          value: HomeProv(),
        )
      ],
      child: Consumer<AuthProv>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'SchoolBuddy',
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          home: auth.isAuth
              ? auth.isSeen ? WelcomeScreen() : SetupScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            AuthScreen.routhName: (ctx) => AuthScreen(),
            WelcomeScreen.routhName: (ctx) => WelcomeScreen(),
            NotesScreen.routhName: (ctx) => NotesScreen(),
            NewNoteScreen.routhName: (ctx) => NewNoteScreen(),
            TimetableScreen.routhName: (ctx) => TimetableScreen(),
            ProfileScreen.routhName: (ctx) => ProfileScreen(),
            ChangePassword.routhName: (ctx) => ChangePassword(),
            ChangeEmail.routhName: (ctx) => ChangeEmail(),
            SetupScreen.routhName: (ctx) => SetupScreen(),
            Homework.routhName: (ctx) => Homework(),
          },
        ),
      ),
    );
  }
}
