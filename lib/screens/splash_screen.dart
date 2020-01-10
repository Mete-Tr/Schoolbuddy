import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routhName = '/newNote';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Neue Notiz erstellen'),
        ),
        body: Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
