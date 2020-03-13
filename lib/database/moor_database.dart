import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Notes extends Table {
  IntColumn get nId => integer()();
  TextColumn get title => text()();
  TextColumn get noteText => text()();

  @override
  Set<Column> get primaryKey => {nId};
}

class Timetables extends Table {
  IntColumn get tId => integer()();
  TextColumn get gender => text()();
  TextColumn get lastname => text()();
  TextColumn get subjectAcronym => text()();
  TextColumn get room => text()();
  BoolColumn get isCancelled => boolean()();
  BoolColumn get isCanged => boolean()();
  TextColumn get massage => text()();

  @override
  Set<Column> get primaryKey => {tId};
}

class HomeworkData extends Table {
  IntColumn get hId => integer()();
  TextColumn get title => text()();
  TextColumn get task => text()();
  BoolColumn get done => boolean()();

  Set<Column> get primaryKey => {hId};
  }

@UseMoor(tables: [Notes, Timetables], daos: [NoteDao, TimetableDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'bd.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
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

@UseDao(tables: [Timetables])
class TimetableDao extends DatabaseAccessor<AppDatabase>
    with _$TimetableDaoMixin, ChangeNotifier {
  final AppDatabase db;

  TimetableDao(this.db) : super(db);

  Future<List<Timetable>> getAlltimet() => select(timetables).get();
  Stream<List<Timetable>> watchAllTimet() => select(timetables).watch();
  Future insertTimet(Insertable<Timetable> timetable) =>
      into(timetables).insert(timetable);
  Future updateTimet(Insertable<Timetable> timetable) =>
      update(timetables).replace(timetable);
  Future deleteTimet(Insertable<Timetable> timetable) =>
      delete(timetables).delete(timetable);
}
