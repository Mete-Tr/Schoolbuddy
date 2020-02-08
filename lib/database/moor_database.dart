import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get noteText => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Timetable extends Table {
  IntColumn get id => integer()();
  TextColumn get lastname => text()();
  TextColumn get gender => text()();
  TextColumn get subject_acronym => text()();
  TextColumn get period => text()();
  TextColumn get interval => text()();
  TextColumn get room => text()();
}

@UseMoor(tables: [Notes, Timetable], daos: [NoteDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'bd.sqlite', logStatements: true));

  @override
  int get schemaVersion => 11;
}

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<AppDatabase>
    with _$NoteDaoMixin, ChangeNotifier {
  final AppDatabase db;

  NoteDao(this.db) : super(db);

  Future<List<Note>> getAllNotes() => select(notes).get();
  Stream<List<Note>> watchAllNotes() => select(notes).watch();
  Future insertNote(Insertable<Note> note) => into(notes).insert(note);
  Future updateNote(Insertable<Note> note) => update(notes).replace(note);
  Future deleteNote(Insertable<Note> note) => delete(notes).delete(note);
}
