import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/moor_database.dart';

class NotesProv with ChangeNotifier {
  final url = 'https://schoolbuddy.herokuapp.com/api/sb/notes/';

  Future<void> postNote(String text, String title, BuildContext context) async {
    final dbNotes = Provider.of<NoteDao>(context);
    final prefs = await SharedPreferences.getInstance();
    final tmp = prefs.getString('userData');
    final token = json.decode(tmp);
    final response = await http.post(url, headers: {
      'Authorization': 'token ' + token['token'],
    }, body: {
      'note_title': title,
      'note_content': text
    });
    final resp = json.decode(response.body);
    final note = NotesCompanion(
      id: Value(resp['id']),
      title: Value(resp['title']),
      noteText: Value(resp['note_content']),
    );
    dbNotes.insertNote(note);
  }

  Future<void> deleteNote(Note note, int id, BuildContext context) async {
    final url = 'http://schoolbuddy.herokuapp.com/api/sb/notes/$id/';
    final dbNotes = Provider.of<NoteDao>(context);
    final prefs = await SharedPreferences.getInstance();
    final tmp = prefs.getString('userData');
    final token = json.decode(tmp);
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'token ' + token['token'],
      },
    );
    dbNotes.deleteNote(note);
  }

  // Future<void> updateNote(Note note, int id, BuildContext context) async {
  //   final url =
  //       'http://ec2-18-189-29-99.us-east-2.compute.amazonaws.com/api/note/$id/';
  //   final dbNotes = Provider.of<NoteDao>(context);
  //   final prefs = await SharedPreferences.getInstance();
  //   final tmp = prefs.getString('userData');
  //   final token = json.decode(tmp);
  //   final response = http.put(url, headers: {
  //     'Authorization': 'token ' + token['token'],
  //   }, body: {
  //     'note_content': note.noteText,
  //     'note_title': note.title,
  //   });
  //   dbNotes.updateNote(note);
  // }
}
