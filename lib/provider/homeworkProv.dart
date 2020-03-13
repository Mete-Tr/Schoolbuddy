import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import '../database/moor_database.dart';

class HomeworkProv with ChangeNotifier {
  void addHomework(String title, String tasks, BuildContext context) {
    final dbHomework = Provider.of<HomeworkDataDao>(context);
    final homework = HomeworkDatasCompanion(
      title: Value(title),
      task: Value('Aufgaben:\n' + tasks)
    );
    dbHomework.insertHomework(homework);
  }

  void updateHomework(HomeworkData homework, BuildContext context) {
  final dbHomework = Provider.of<HomeworkDataDao>(context);
  dbHomework.updateHomework(homework);
  }

  void deleteHomework(HomeworkData homework, BuildContext context) {
    final dbHomework = Provider.of<HomeworkDataDao>(context);
    dbHomework.deleteHomework(homework);
  }
}