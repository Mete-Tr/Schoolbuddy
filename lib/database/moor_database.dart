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
  TextColumn get lastname => text()();
  TextColumn get gender => text()();
  TextColumn get subjectAcronym => text()();
  TextColumn get room => text()();
  BoolColumn get isCancelled => boolean().withDefault(Constant(false))();
  BoolColumn get isCanged => boolean().withDefault(Constant(false))();
  TextColumn get massage => text()();
  TextColumn get color => text()();
  TextColumn get courseDay => text()();

  @override
  Set<Column> get primaryKey => {tId};
}

class HomeworkDatas extends Table {
  IntColumn get hId => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get task => text()();
  BoolColumn get done => boolean().withDefault(Constant(false))();
  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime.now()))();

  Set<Column> get primaryKey => {hId};
  }

@UseMoor(tables: [Notes, Timetables, HomeworkDatas], daos: [NoteDao, TimetableDao, HomeworkDataDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'bd.sqlite', logStatements: true));

  @override
  int get schemaVersion => 5;
}

@UseDao(tables: [HomeworkDatas])
class HomeworkDataDao extends DatabaseAccessor<AppDatabase>
 with _$HomeworkDataDaoMixin, ChangeNotifier {
  final AppDatabase db;

  HomeworkDataDao(this.db) : super(db);

  
  
  Future<List<HomeworkData>> getAllHomeworks() => select(homeworkDatas).get();
  Stream<List<HomeworkData>> watchAllHomeworks() {
    return (select(homeworkDatas)
    ..orderBy([
      (t) => OrderingTerm(expression: t.hId, mode: OrderingMode.desc)
    ])).watch();
  }
  Stream<List<HomeworkData>> watchDoneHomeworks() {
    return (select(homeworkDatas)
    ..orderBy([
      (t) => OrderingTerm(expression: t.hId, mode: OrderingMode.desc)
    ])
    ..where((t) => t.done.equals(false))).watch();
  }
  Future insertHomework(Insertable<HomeworkData> homeworkData) => into(homeworkDatas).insert(homeworkData);
  Future updateHomework(Insertable<HomeworkData> homeworkData) => update(homeworkDatas).replace(homeworkData);
  Future deleteHomework(Insertable<HomeworkData> homeworkData) => delete(homeworkDatas).delete(homeworkData);
  }

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<AppDatabase>
    with _$NoteDaoMixin, ChangeNotifier {
  final AppDatabase db;

  NoteDao(this.db) : super(db);

  Future<List<Note>> getAllNotes() => select(notes).get();
  Stream<List<Note>> watchAllNotes()  {
    return (select(notes)
    ..orderBy([
      (t) => OrderingTerm(expression: t.nId, mode: OrderingMode.desc)
    ])).watch();
  }
  Future insertNote(Insertable<Note> note) => into(notes).insert(note);
  Future updateNote(Insertable<Note> note) => update(notes).replace(note);
  Future deleteNote(Insertable<Note> note) => delete(notes).delete(note);
}

@UseDao(tables: [Timetables])
class TimetableDao extends DatabaseAccessor<AppDatabase>
    with _$TimetableDaoMixin, ChangeNotifier {
  final AppDatabase db;

  TimetableDao(this.db) : super(db);

  Future<List<Timetable>> getAllTimetable() => select(timetables).get();
  Stream<List<Timetable>> watchAllTimetable() => select(timetables).watch();
  Stream<List<Timetable>> watchTimetableDay(String today) {
    return (select(timetables)
    ..where((t) => t.courseDay.equals(today))).watch();
  }
  Future insertTimetable(Insertable<Timetable> timetable) =>
      into(timetables).insert(timetable);
  Future updateTimetable(Insertable<Timetable> timetable) =>
      update(timetables).replace(timetable);
  Future deleteTimetable(Insertable<Timetable> timetable) =>
      delete(timetables).delete(timetable);
}
