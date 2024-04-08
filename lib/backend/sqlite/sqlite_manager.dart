import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

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
      'lite_zed',
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

  Future<List<GetTopicsInSubjectsFromSylabiRow>> getTopicsInSubjectsFromSylabi({
    int? syllabiId,
  }) =>
      performGetTopicsInSubjectsFromSylabi(
        _database,
        syllabiId: syllabiId,
      );

  Future<List<GetLessonsInTopicsRow>> getLessonsInTopics({
    String? topicId,
  }) =>
      performGetLessonsInTopics(
        _database,
        topicId: topicId,
      );

  Future<List<AllLessonsRow>> allLessons() => performAllLessons(
        _database,
      );

  Future<List<GetSingleSyllabiRow>> getSingleSyllabi({
    int? syllabusId,
  }) =>
      performGetSingleSyllabi(
        _database,
        syllabusId: syllabusId,
      );

  Future<List<GetSubtopicsFromTopicIdRow>> getSubtopicsFromTopicId({
    int? topicId,
  }) =>
      performGetSubtopicsFromTopicId(
        _database,
        topicId: topicId,
      );

  Future<List<GetLessonsFromSubtopicsRow>> getLessonsFromSubtopics({
    int? subtopicId,
  }) =>
      performGetLessonsFromSubtopics(
        _database,
        subtopicId: subtopicId,
      );

  Future<List<GetSingleLessonRow>> getSingleLesson({
    String? lessonId,
  }) =>
      performGetSingleLesson(
        _database,
        lessonId: lessonId,
      );

  Future<List<GetSingleLessonJsonRow>> getSingleLessonJson({
    int? lessonId,
  }) =>
      performGetSingleLessonJson(
        _database,
        lessonId: lessonId,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future createLocalUser({
    String? userName,
    String? userEmail,
    DateTime? createdAt,
  }) =>
      performCreateLocalUser(
        _database,
        userName: userName,
        userEmail: userEmail,
        createdAt: createdAt,
      );

  Future updateUserAccountName({
    String? userName,
    String? currentId,
  }) =>
      performUpdateUserAccountName(
        _database,
        userName: userName,
        currentId: currentId,
      );

  /// END UPDATE QUERY CALLS
}
