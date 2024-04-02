import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN GET ALL GRADES
Future<List<GetAllGradesRow>> performGetAllGrades(
  Database database,
) {
  const query = '''
SELECT * FROM grades;

''';
  return _readQuery(database, query, (d) => GetAllGradesRow(d));
}

class GetAllGradesRow extends SqliteRow {
  GetAllGradesRow(super.data);
}

/// END GET ALL GRADES

/// BEGIN GET SUBJECTS IN GRADE
Future<List<GetSubjectsInGradeRow>> performGetSubjectsInGrade(
  Database database, {
  String? gradeId,
}) {
  final query = '''
SELECT s.*
FROM subjects s
JOIN syllabi sy ON s.subject_id = sy.subject_id
JOIN grades g ON sy.grade_id = g.grade_id
WHERE g.grade_id = $gradeId;

''';
  return _readQuery(database, query, (d) => GetSubjectsInGradeRow(d));
}

class GetSubjectsInGradeRow extends SqliteRow {
  GetSubjectsInGradeRow(super.data);
}

/// END GET SUBJECTS IN GRADE

/// BEGIN GET TOPICS IN SUBJECTS
Future<List<GetTopicsInSubjectsRow>> performGetTopicsInSubjects(
  Database database, {
  String? subjectId,
}) {
  final query = '''
SELECT t.*
FROM topics t
JOIN syllabi sy ON t.syllabus_id = sy.syllabus_id
JOIN subjects s ON sy.subject_id = s.subject_id
WHERE s.subject_id = $subjectId;

''';
  return _readQuery(database, query, (d) => GetTopicsInSubjectsRow(d));
}

class GetTopicsInSubjectsRow extends SqliteRow {
  GetTopicsInSubjectsRow(super.data);
}

/// END GET TOPICS IN SUBJECTS

/// BEGIN GET LESSONS IN TOPICS
Future<List<GetLessonsInTopicsRow>> performGetLessonsInTopics(
  Database database, {
  String? topicId,
}) {
  final query = '''
SELECT l.*
FROM lessons l
JOIN topics t ON l.topic_id = t.topic_id
WHERE t.topic_id = $topicId;

''';
  return _readQuery(database, query, (d) => GetLessonsInTopicsRow(d));
}

class GetLessonsInTopicsRow extends SqliteRow {
  GetLessonsInTopicsRow(super.data);
}

/// END GET LESSONS IN TOPICS
