// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String title;
  final String noteText;
  Note({@required this.id, @required this.title, @required this.noteText});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      noteText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_text']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Note(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      noteText: serializer.fromJson<String>(json['noteText']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'noteText': serializer.toJson<String>(noteText),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      noteText: noteText == null && nullToAbsent
          ? const Value.absent()
          : Value(noteText),
    );
  }

  Note copyWith({int id, String title, String noteText}) => Note(
        id: id ?? this.id,
        title: title ?? this.title,
        noteText: noteText ?? this.noteText,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('noteText: $noteText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(title.hashCode, noteText.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.noteText == this.noteText);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> noteText;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.noteText = const Value.absent(),
  });
  NotesCompanion.insert({
    @required int id,
    @required String title,
    @required String noteText,
  })  : id = Value(id),
        title = Value(title),
        noteText = Value(noteText);
  NotesCompanion copyWith(
      {Value<int> id, Value<String> title, Value<String> noteText}) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      noteText: noteText ?? this.noteText,
    );
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
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
  List<GeneratedColumn> get $columns => [id, title, noteText];
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
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Note.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  NoteDao _noteDao;
  NoteDao get noteDao => _noteDao ??= NoteDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [notes];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$NoteDaoMixin on DatabaseAccessor<AppDatabase> {
  $NotesTable get notes => db.notes;
}
