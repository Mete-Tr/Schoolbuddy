import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/database/moor_database.dart';
import 'package:x/provider/notesProv.dart';

import '../screens/new_note_screen.dart';
import '../widgets/app_drawer.dart';

class NotesScreen extends StatefulWidget {
  static const routhName = '/note';

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Notizen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(NewNoteScreen.routhName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5, right: 5),
        child: NotesList(),
      ),
    );
  }
}

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final dao = Provider.of<NoteDao>(context);
    final noteProv = Provider.of<NotesProv>(context);

    return StreamBuilder(
      stream: dao.watchAllNotes(),
      builder: (context, AsyncSnapshot<List<Note>> snapshot) {
        final list = snapshot.data ?? List();
        return Container(
          height: device.height,
          child: list.isEmpty
              ? Center(
                  child: Text(
                    'Keine Notizen vorhanden',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, i) {
                    return Dismissible(
                      key: Key(UniqueKey().toString()),
                      background: Container(
                        color: Theme.of(context).errorColor,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) {
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Bist du sicher?'),
                            content: Text(
                              'Willst du diese Notiz löschen?',
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Nein'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                              ),
                              FlatButton(
                                child: Text('Ja'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) {
                        noteProv.deleteNote(list[i], list[i].nId, context);
                      },
                      child: Card(
                        elevation: 8,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            title: Text(
                              list[i].title,
                              textScaleFactor: 1.5,
                            ),
                            subtitle: Text(
                              list[i].noteText,
                              textScaleFactor: 1.3,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
