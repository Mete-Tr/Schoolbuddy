import 'package:flutter/material.dart';

class NewHMScreen extends StatefulWidget {
  static const routhName = '/NewHA';
  @override
  _NewHMScreenState createState() => _NewHMScreenState();
}

class _NewHMScreenState extends State<NewHMScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neue Hausaufgabe'),
      ),
      body: Container(),
    );
  }
}