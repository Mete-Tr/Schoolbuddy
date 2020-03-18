// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final int nId;
  final String title;
  final String noteText;
  Note({@required this.nId, @required this.title, @required this.noteText});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Note(
      nId: intType.mapFromDatabaseResponse(data['${effectivePrefix}n_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      noteText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_text']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Note(
      nId: serializer.fromJson<int>(json['nId']),
      title: serializer.fromJson<String>(json['title']),
      noteText: serializer.fromJson<String>(json['noteText']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'nId': serializer.toJson<int>(nId),
      'title': serializer.toJson<String>(title),
      'noteText': serializer.toJson<String>(noteText),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      nId: nId == null && nullToAbsent ? const Value.absent() : Value(nId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      noteText: noteText == null && nullToAbsent
          ? const Value.absent()
          : Value(noteText),
    );
  }

  Note copyWith({int nId, String title, String noteText}) => Note(
        nId: nId ?? this.nId,
        title: title ?? this.title,
        noteText: noteText ?? this.noteText,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('nId: $nId, ')
          ..write('title: $title, ')
          ..write('noteText: $noteText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(nId.hashCode, $mrjc(title.hashCode, noteText.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Note &&
          other.nId == this.nId &&
          other.title == this.title &&
          other.noteText == this.noteText);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> nId;
  final Value<String> title;
  final Value<String> noteText;
  const NotesCompanion({
    this.nId = const Value.absent(),
    this.title = const Value.absent(),
    this.noteText = const Value.absent(),
  });
  NotesCompanion.insert({
    @required int nId,
    @required String title,
    @required String noteText,
  })  : nId = Value(nId),
        title = Value(title),
        noteText = Value(noteText);
  NotesCompanion copyWith(
      {Value<int> nId, Value<String> title, Value<String> noteText}) {
    return NotesCompanion(
      nId: nId ?? this.nId,
      title: title ?? this.title,
      noteText: noteText ?? this.noteText,
    );
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _nIdMeta = const VerificationMeta('nId');
  GeneratedIntColumn _nId;
  @override
  GeneratedIntColumn get nId => _nId ??= _constructNId();
  GeneratedIntColumn _constructNId() {
    return GeneratedIntColumn(
      'n_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _noteTextMeta = const VerificationMeta('noteText');
  GeneratedTextColumn _noteText;
  @override
  GeneratedTextColumn get noteText => _noteText ??= _constructNoteText();
  GeneratedTextColumn _constructNoteText() {
    return GeneratedTextColumn(
      'note_text',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [nId, title, noteText];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(NotesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.nId.present) {
      context.handle(_nIdMeta, nId.isAcceptableValue(d.nId.value, _nIdMeta));
    } else if (nId.isRequired && isInserting) {
      context.missing(_nIdMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.noteText.present) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableValue(d.noteText.value, _noteTextMeta));
    } else if (noteText.isRequired && isInserting) {
      context.missing(_noteTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {nId};
  @override
  Note map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Note.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.nId.present) {
      map['n_id'] = Variable<int, IntType>(d.nId.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.noteText.present) {
      map['note_text'] = Variable<String, StringType>(d.noteText.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

class Timetable extends DataClass implements Insertable<Timetable> {
  final int tId;
  final String lastname;
  final String subjectAcronym;
  final String room;
  final bool isCancelled;
  final bool isCanged;
  final String massage;
  final String color;
  final String courseDay;
  Timetable(
      {@required this.tId,
      @required this.lastname,
      @required this.subjectAcronym,
      @required this.room,
      @required this.isCancelled,
      @required this.isCanged,
      @required this.massage,
      @required this.color,
      @required this.courseDay});
  factory Timetable.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Timetable(
      tId: intType.mapFromDatabaseResponse(data['${effectivePrefix}t_id']),
      lastname: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}lastname']),
      subjectAcronym: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}subject_acronym']),
      room: stringType.mapFromDatabaseResponse(data['${effectivePrefix}room']),
      isCancelled: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_cancelled']),
      isCanged:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_canged']),
      massage:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}massage']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      courseDay: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}course_day']),
    );
  }
  factory Timetable.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Timetable(
      tId: serializer.fromJson<int>(json['tId']),
      lastname: serializer.fromJson<String>(json['lastname']),
      subjectAcronym: serializer.fromJson<String>(json['subjectAcronym']),
      room: serializer.fromJson<String>(json['room']),
      isCancelled: serializer.fromJson<bool>(json['isCancelled']),
      isCanged: serializer.fromJson<bool>(json['isCanged']),
      massage: serializer.fromJson<String>(json['massage']),
      color: serializer.fromJson<String>(json['color']),
      courseDay: serializer.fromJson<String>(json['courseDay']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'tId': serializer.toJson<int>(tId),
      'lastname': serializer.toJson<String>(lastname),
      'subjectAcronym': serializer.toJson<String>(subjectAcronym),
      'room': serializer.toJson<String>(room),
      'isCancelled': serializer.toJson<bool>(isCancelled),
      'isCanged': serializer.toJson<bool>(isCanged),
      'massage': serializer.toJson<String>(massage),
      'color': serializer.toJson<String>(color),
      'courseDay': serializer.toJson<String>(courseDay),
    };
  }

  @override
  TimetablesCompanion createCompanion(bool nullToAbsent) {
    return TimetablesCompanion(
      tId: tId == null && nullToAbsent ? const Value.absent() : Value(tId),
      lastname: lastname == null && nullToAbsent
          ? const Value.absent()
          : Value(lastname),
      subjectAcronym: subjectAcronym == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectAcronym),
      room: room == null && nullToAbsent ? const Value.absent() : Value(room),
      isCancelled: isCancelled == null && nullToAbsent
          ? const Value.absent()
          : Value(isCancelled),
      isCanged: isCanged == null && nullToAbsent
          ? const Value.absent()
          : Value(isCanged),
      massage: massage == null && nullToAbsent
          ? const Value.absent()
          : Value(massage),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      courseDay: courseDay == null && nullToAbsent
          ? const Value.absent()
          : Value(courseDay),
    );
  }

  Timetable copyWith(
          {int tId,
          String lastname,
          String subjectAcronym,
          String room,
          bool isCancelled,
          bool isCanged,
          String massage,
          String color,
          String courseDay}) =>
      Timetable(
        tId: tId ?? this.tId,
        lastname: lastname ?? this.lastname,
        subjectAcronym: subjectAcronym ?? this.subjectAcronym,
        room: room ?? this.room,
        isCancelled: isCancelled ?? this.isCancelled,
        isCanged: isCanged ?? this.isCanged,
        massage: massage ?? this.massage,
        color: color ?? this.color,
        courseDay: courseDay ?? this.courseDay,
      );
  @override
  String toString() {
    return (StringBuffer('Timetable(')
          ..write('tId: $tId, ')
          ..write('lastname: $lastname, ')
          ..write('subjectAcronym: $subjectAcronym, ')
          ..write('room: $room, ')
          ..write('isCancelled: $isCancelled, ')
          ..write('isCanged: $isCanged, ')
          ..write('massage: $massage, ')
          ..write('color: $color, ')
          ..write('courseDay: $courseDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      tId.hashCode,
      $mrjc(
          lastname.hashCode,
          $mrjc(
              subjectAcronym.hashCode,
              $mrjc(
                  room.hashCode,
                  $mrjc(
                      isCancelled.hashCode,
                      $mrjc(
                          isCanged.hashCode,
                          $mrjc(massage.hashCode,
                              $mrjc(color.hashCode, courseDay.hashCode)))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Timetable &&
          other.tId == this.tId &&
          other.lastname == this.lastname &&
          other.subjectAcronym == this.subjectAcronym &&
          other.room == this.room &&
          other.isCancelled == this.isCancelled &&
          other.isCanged == this.isCanged &&
          other.massage == this.massage &&
          other.color == this.color &&
          other.courseDay == this.courseDay);
}

class TimetablesCompanion extends UpdateCompanion<Timetable> {
  final Value<int> tId;
  final Value<String> lastname;
  final Value<String> subjectAcronym;
  final Value<String> room;
  final Value<bool> isCancelled;
  final Value<bool> isCanged;
  final Value<String> massage;
  final Value<String> color;
  final Value<String> courseDay;
  const TimetablesCompanion({
    this.tId = const Value.absent(),
    this.lastname = const Value.absent(),
    this.subjectAcronym = const Value.absent(),
    this.room = const Value.absent(),
    this.isCancelled = const Value.absent(),
    this.isCanged = const Value.absent(),
    this.massage = const Value.absent(),
    this.color = const Value.absent(),
    this.courseDay = const Value.absent(),
  });
  TimetablesCompanion.insert({
    @required int tId,
    @required String lastname,
    @required String subjectAcronym,
    @required String room,
    this.isCancelled = const Value.absent(),
    this.isCanged = const Value.absent(),
    @required String massage,
    @required String color,
    @required String courseDay,
  })  : tId = Value(tId),
        lastname = Value(lastname),
        subjectAcronym = Value(subjectAcronym),
        room = Value(room),
        massage = Value(massage),
        color = Value(color),
        courseDay = Value(courseDay);
  TimetablesCompanion copyWith(
      {Value<int> tId,
      Value<String> lastname,
      Value<String> subjectAcronym,
      Value<String> room,
      Value<bool> isCancelled,
      Value<bool> isCanged,
      Value<String> massage,
      Value<String> color,
      Value<String> courseDay}) {
    return TimetablesCompanion(
      tId: tId ?? this.tId,
      lastname: lastname ?? this.lastname,
      subjectAcronym: subjectAcronym ?? this.subjectAcronym,
      room: room ?? this.room,
      isCancelled: isCancelled ?? this.isCancelled,
      isCanged: isCanged ?? this.isCanged,
      massage: massage ?? this.massage,
      color: color ?? this.color,
      courseDay: courseDay ?? this.courseDay,
    );
  }
}

class $TimetablesTable extends Timetables
    with TableInfo<$TimetablesTable, Timetable> {
  final GeneratedDatabase _db;
  final String _alias;
  $TimetablesTable(this._db, [this._alias]);
  final VerificationMeta _tIdMeta = const VerificationMeta('tId');
  GeneratedIntColumn _tId;
  @override
  GeneratedIntColumn get tId => _tId ??= _constructTId();
  GeneratedIntColumn _constructTId() {
    return GeneratedIntColumn(
      't_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastnameMeta = const VerificationMeta('lastname');
  GeneratedTextColumn _lastname;
  @override
  GeneratedTextColumn get lastname => _lastname ??= _constructLastname();
  GeneratedTextColumn _constructLastname() {
    return GeneratedTextColumn(
      'lastname',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subjectAcronymMeta =
      const VerificationMeta('subjectAcronym');
  GeneratedTextColumn _subjectAcronym;
  @override
  GeneratedTextColumn get subjectAcronym =>
      _subjectAcronym ??= _constructSubjectAcronym();
  GeneratedTextColumn _constructSubjectAcronym() {
    return GeneratedTextColumn(
      'subject_acronym',
      $tableName,
      false,
    );
  }

  final VerificationMeta _roomMeta = const VerificationMeta('room');
  GeneratedTextColumn _room;
  @override
  GeneratedTextColumn get room => _room ??= _constructRoom();
  GeneratedTextColumn _constructRoom() {
    return GeneratedTextColumn(
      'room',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isCancelledMeta =
      const VerificationMeta('isCancelled');
  GeneratedBoolColumn _isCancelled;
  @override
  GeneratedBoolColumn get isCancelled =>
      _isCancelled ??= _constructIsCancelled();
  GeneratedBoolColumn _constructIsCancelled() {
    return GeneratedBoolColumn('is_cancelled', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _isCangedMeta = const VerificationMeta('isCanged');
  GeneratedBoolColumn _isCanged;
  @override
  GeneratedBoolColumn get isCanged => _isCanged ??= _constructIsCanged();
  GeneratedBoolColumn _constructIsCanged() {
    return GeneratedBoolColumn('is_canged', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _massageMeta = const VerificationMeta('massage');
  GeneratedTextColumn _massage;
  @override
  GeneratedTextColumn get massage => _massage ??= _constructMassage();
  GeneratedTextColumn _constructMassage() {
    return GeneratedTextColumn(
      'massage',
      $tableName,
      false,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn(
      'color',
      $tableName,
      false,
    );
  }

  final VerificationMeta _courseDayMeta = const VerificationMeta('courseDay');
  GeneratedTextColumn _courseDay;
  @override
  GeneratedTextColumn get courseDay => _courseDay ??= _constructCourseDay();
  GeneratedTextColumn _constructCourseDay() {
    return GeneratedTextColumn(
      'course_day',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        tId,
        lastname,
        subjectAcronym,
        room,
        isCancelled,
        isCanged,
        massage,
        color,
        courseDay
      ];
  @override
  $TimetablesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'timetables';
  @override
  final String actualTableName = 'timetables';
  @override
  VerificationContext validateIntegrity(TimetablesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.tId.present) {
      context.handle(_tIdMeta, tId.isAcceptableValue(d.tId.value, _tIdMeta));
    } else if (tId.isRequired && isInserting) {
      context.missing(_tIdMeta);
    }
    if (d.lastname.present) {
      context.handle(_lastnameMeta,
          lastname.isAcceptableValue(d.lastname.value, _lastnameMeta));
    } else if (lastname.isRequired && isInserting) {
      context.missing(_lastnameMeta);
    }
    if (d.subjectAcronym.present) {
      context.handle(
          _subjectAcronymMeta,
          subjectAcronym.isAcceptableValue(
              d.subjectAcronym.value, _subjectAcronymMeta));
    } else if (subjectAcronym.isRequired && isInserting) {
      context.missing(_subjectAcronymMeta);
    }
    if (d.room.present) {
      context.handle(
          _roomMeta, room.isAcceptableValue(d.room.value, _roomMeta));
    } else if (room.isRequired && isInserting) {
      context.missing(_roomMeta);
    }
    if (d.isCancelled.present) {
      context.handle(_isCancelledMeta,
          isCancelled.isAcceptableValue(d.isCancelled.value, _isCancelledMeta));
    } else if (isCancelled.isRequired && isInserting) {
      context.missing(_isCancelledMeta);
    }
    if (d.isCanged.present) {
      context.handle(_isCangedMeta,
          isCanged.isAcceptableValue(d.isCanged.value, _isCangedMeta));
    } else if (isCanged.isRequired && isInserting) {
      context.missing(_isCangedMeta);
    }
    if (d.massage.present) {
      context.handle(_massageMeta,
          massage.isAcceptableValue(d.massage.value, _massageMeta));
    } else if (massage.isRequired && isInserting) {
      context.missing(_massageMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    if (d.courseDay.present) {
      context.handle(_courseDayMeta,
          courseDay.isAcceptableValue(d.courseDay.value, _courseDayMeta));
    } else if (courseDay.isRequired && isInserting) {
      context.missing(_courseDayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tId};
  @override
  Timetable map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Timetable.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TimetablesCompanion d) {
    final map = <String, Variable>{};
    if (d.tId.present) {
      map['t_id'] = Variable<int, IntType>(d.tId.value);
    }
    if (d.lastname.present) {
      map['lastname'] = Variable<String, StringType>(d.lastname.value);
    }
    if (d.subjectAcronym.present) {
      map['subject_acronym'] =
          Variable<String, StringType>(d.subjectAcronym.value);
    }
    if (d.room.present) {
      map['room'] = Variable<String, StringType>(d.room.value);
    }
    if (d.isCancelled.present) {
      map['is_cancelled'] = Variable<bool, BoolType>(d.isCancelled.value);
    }
    if (d.isCanged.present) {
      map['is_canged'] = Variable<bool, BoolType>(d.isCanged.value);
    }
    if (d.massage.present) {
      map['massage'] = Variable<String, StringType>(d.massage.value);
    }
    if (d.color.present) {
      map['color'] = Variable<String, StringType>(d.color.value);
    }
    if (d.courseDay.present) {
      map['course_day'] = Variable<String, StringType>(d.courseDay.value);
    }
    return map;
  }

  @override
  $TimetablesTable createAlias(String alias) {
    return $TimetablesTable(_db, alias);
  }
}

class HomeworkData extends DataClass implements Insertable<HomeworkData> {
  final int hId;
  final String title;
  final String task;
  final bool done;
  final DateTime date;
  HomeworkData(
      {@required this.hId,
      @required this.title,
      @required this.task,
      @required this.done,
      @required this.date});
  factory HomeworkData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return HomeworkData(
      hId: intType.mapFromDatabaseResponse(data['${effectivePrefix}h_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      task: stringType.mapFromDatabaseResponse(data['${effectivePrefix}task']),
      done: boolType.mapFromDatabaseResponse(data['${effectivePrefix}done']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  factory HomeworkData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return HomeworkData(
      hId: serializer.fromJson<int>(json['hId']),
      title: serializer.fromJson<String>(json['title']),
      task: serializer.fromJson<String>(json['task']),
      done: serializer.fromJson<bool>(json['done']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'hId': serializer.toJson<int>(hId),
      'title': serializer.toJson<String>(title),
      'task': serializer.toJson<String>(task),
      'done': serializer.toJson<bool>(done),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  @override
  HomeworkDatasCompanion createCompanion(bool nullToAbsent) {
    return HomeworkDatasCompanion(
      hId: hId == null && nullToAbsent ? const Value.absent() : Value(hId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      task: task == null && nullToAbsent ? const Value.absent() : Value(task),
      done: done == null && nullToAbsent ? const Value.absent() : Value(done),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  HomeworkData copyWith(
          {int hId, String title, String task, bool done, DateTime date}) =>
      HomeworkData(
        hId: hId ?? this.hId,
        title: title ?? this.title,
        task: task ?? this.task,
        done: done ?? this.done,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('HomeworkData(')
          ..write('hId: $hId, ')
          ..write('title: $title, ')
          ..write('task: $task, ')
          ..write('done: $done, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      hId.hashCode,
      $mrjc(title.hashCode,
          $mrjc(task.hashCode, $mrjc(done.hashCode, date.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is HomeworkData &&
          other.hId == this.hId &&
          other.title == this.title &&
          other.task == this.task &&
          other.done == this.done &&
          other.date == this.date);
}

class HomeworkDatasCompanion extends UpdateCompanion<HomeworkData> {
  final Value<int> hId;
  final Value<String> title;
  final Value<String> task;
  final Value<bool> done;
  final Value<DateTime> date;
  const HomeworkDatasCompanion({
    this.hId = const Value.absent(),
    this.title = const Value.absent(),
    this.task = const Value.absent(),
    this.done = const Value.absent(),
    this.date = const Value.absent(),
  });
  HomeworkDatasCompanion.insert({
    this.hId = const Value.absent(),
    @required String title,
    @required String task,
    this.done = const Value.absent(),
    this.date = const Value.absent(),
  })  : title = Value(title),
        task = Value(task);
  HomeworkDatasCompanion copyWith(
      {Value<int> hId,
      Value<String> title,
      Value<String> task,
      Value<bool> done,
      Value<DateTime> date}) {
    return HomeworkDatasCompanion(
      hId: hId ?? this.hId,
      title: title ?? this.title,
      task: task ?? this.task,
      done: done ?? this.done,
      date: date ?? this.date,
    );
  }
}

class $HomeworkDatasTable extends HomeworkDatas
    with TableInfo<$HomeworkDatasTable, HomeworkData> {
  final GeneratedDatabase _db;
  final String _alias;
  $HomeworkDatasTable(this._db, [this._alias]);
  final VerificationMeta _hIdMeta = const VerificationMeta('hId');
  GeneratedIntColumn _hId;
  @override
  GeneratedIntColumn get hId => _hId ??= _constructHId();
  GeneratedIntColumn _constructHId() {
    return GeneratedIntColumn('h_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taskMeta = const VerificationMeta('task');
  GeneratedTextColumn _task;
  @override
  GeneratedTextColumn get task => _task ??= _constructTask();
  GeneratedTextColumn _constructTask() {
    return GeneratedTextColumn(
      'task',
      $tableName,
      false,
    );
  }

  final VerificationMeta _doneMeta = const VerificationMeta('done');
  GeneratedBoolColumn _done;
  @override
  GeneratedBoolColumn get done => _done ??= _constructDone();
  GeneratedBoolColumn _constructDone() {
    return GeneratedBoolColumn('done', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn('date', $tableName, false,
        defaultValue: Constant(DateTime.now()));
  }

  @override
  List<GeneratedColumn> get $columns => [hId, title, task, done, date];
  @override
  $HomeworkDatasTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'homework_datas';
  @override
  final String actualTableName = 'homework_datas';
  @override
  VerificationContext validateIntegrity(HomeworkDatasCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.hId.present) {
      context.handle(_hIdMeta, hId.isAcceptableValue(d.hId.value, _hIdMeta));
    } else if (hId.isRequired && isInserting) {
      context.missing(_hIdMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.task.present) {
      context.handle(
          _taskMeta, task.isAcceptableValue(d.task.value, _taskMeta));
    } else if (task.isRequired && isInserting) {
      context.missing(_taskMeta);
    }
    if (d.done.present) {
      context.handle(
          _doneMeta, done.isAcceptableValue(d.done.value, _doneMeta));
    } else if (done.isRequired && isInserting) {
      context.missing(_doneMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {hId};
  @override
  HomeworkData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return HomeworkData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(HomeworkDatasCompanion d) {
    final map = <String, Variable>{};
    if (d.hId.present) {
      map['h_id'] = Variable<int, IntType>(d.hId.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.task.present) {
      map['task'] = Variable<String, StringType>(d.task.value);
    }
    if (d.done.present) {
      map['done'] = Variable<bool, BoolType>(d.done.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    return map;
  }

  @override
  $HomeworkDatasTable createAlias(String alias) {
    return $HomeworkDatasTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  $TimetablesTable _timetables;
  $TimetablesTable get timetables => _timetables ??= $TimetablesTable(this);
  $HomeworkDatasTable _homeworkDatas;
  $HomeworkDatasTable get homeworkDatas =>
      _homeworkDatas ??= $HomeworkDatasTable(this);
  NoteDao _noteDao;
  NoteDao get noteDao => _noteDao ??= NoteDao(this as AppDatabase);
  TimetableDao _timetableDao;
  TimetableDao get timetableDao =>
      _timetableDao ??= TimetableDao(this as AppDatabase);
  HomeworkDataDao _homeworkDataDao;
  HomeworkDataDao get homeworkDataDao =>
      _homeworkDataDao ??= HomeworkDataDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [notes, timetables, homeworkDatas];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$HomeworkDataDaoMixin on DatabaseAccessor<AppDatabase> {
  $HomeworkDatasTable get homeworkDatas => db.homeworkDatas;
}
mixin _$NoteDaoMixin on DatabaseAccessor<AppDatabase> {
  $NotesTable get notes => db.notes;
}
mixin _$TimetableDaoMixin on DatabaseAccessor<AppDatabase> {
  $TimetablesTable get timetables => db.timetables;
}
