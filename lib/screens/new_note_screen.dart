import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/provider/notesProv.dart';

class NewNoteScreen extends StatefulWidget {
  static const routhName = '/newNote';
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final titleController = TextEditingController();
    final device = MediaQuery.of(context).size;
    final noteProv = Provider.of<NotesProv>(context);
    final noteData = {'title': '', 'text': ''};

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Neue Notiz erstellen'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: device.height,
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Titel'),
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      noteData['title'] = val;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Gib deinen Tet ein'),
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    onChanged: (val) {
                      noteData['text'] = val;
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'Speichern',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      noteProv.postNote(
                          noteData['text'], noteData['title'], context);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
