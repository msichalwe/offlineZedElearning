import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'lite',
      'sqlLiteElearning.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<GetAllGradesRow>> getAllGrades() => performGetAllGrades(
        _database,
      );

  Future<List<GetSubjectsInGradeRow>> getSubjectsInGrade({
    String? gradeId,
  }) =>
      performGetSubjectsInGrade(
        _database,
        gradeId: gradeId,
      );

  Future<List<GetTopicsInSubjectsRow>> getTopicsInSubjects({
    String? subjectId,
  }) =>
      performGetTopicsInSubjects(
        _database,
        subjectId: subjectId,
      );

  Future<List<GetLessonsInTopicsRow>> getLessonsInTopics({
    String? topicId,
  }) =>
      performGetLessonsInTopics(
        _database,
        topicId: topicId,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  /// END UPDATE QUERY CALLS
}
