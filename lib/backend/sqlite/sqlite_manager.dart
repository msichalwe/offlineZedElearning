import 'package:flutter/foundation.dart';
import 'package:school_platform_windows/backend/sqlite/queries/write.dart';

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
      'lite_zed7',
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

  Future<List<GetSingleLessonColumnsRow>> getSingleLessonColumns({
    int? lessonId,
  }) =>
      performGetSingleLessonColumns(
        _database,
        lessonId: lessonId,
      );

  Future<List<GetPhasesFromLessonIdRow>> getPhasesFromLessonId({
    int? lessonId,
  }) =>
      performGetPhasesFromLessonId(
        _database,
        lessonId: lessonId,
      );

  Future<List<GetLessonAssessmentsRow>> getAssessmentsFromLessonId({
    int? lessonId,
  }) =>
      performGetLessonAssessments(
        _database,
        lessonAssessmentId: lessonId,
      );

  Future<List<LessonGradeCountRow>> getLessonGradeCount(
          {int? gradeId, String? subjectName}) =>
      performGetLessonGradeCount(_database,
          gradeId: gradeId, subjectName: subjectName);

  Future<List<AssessmentGradeCountRow>> getAssessmentGradeCount(
          {int? gradeId, String? subjectName}) =>
      performGetAssessmentGradeCount(_database,
          gradeId: gradeId, subjectName: subjectName);

  Future<List<SingleAssessmentRow>> getAssessment({
    int? assessmentId,
  }) =>
      performGetSingleAssessment(
        _database,
        assessmentId: assessmentId,
      );

  Future<List<SingleAssessmentGradeRow>> getAssessmentGrade(
          {int? assessmentId, int? userId}) =>
      performGetSingleAssessmentGrade(_database,
          assessmentId: assessmentId, userId: userId);


  Future<List<SearchSubtopic>> getSubtopicQuery(
      {String? subtopic}) =>
      searchSubtopic(_database,
          subtopic: subtopic );


  Future<List<Syllabi>> getSyllabi(
      {String? search}) =>
      searchSyllabi(_database,
          searchTerm: search );

  Future<List<CountLessons>> countLessons(
      ) =>
      lessonCount(_database,
           );

  Future<List<CountAssessments>> countAssessments(
      ) =>
      assessmentCount(_database,
      );


  Future<List<ScoreSheetData>> getScoresheetData(
      ) =>
      scoresheetData(_database,
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

  /// START INSERT QUERY CALLS

  Future createGrade({
    int? user_id,
    int? assessmentId,
    double? percentageScore,
    String? submittedAnswers,
    DateTime? createdAt,
  }) =>
      performCreateAssessmentGrade(_database,
          user_id: user_id,
          assessmentId: assessmentId,
          percentageScore: percentageScore,
          submittedAnswers: submittedAnswers,
          createdAt: DateTime.now());

  /// START INSERT QUERY CALLS
}
