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
SELECT grade_id AS gradeId, grade_name AS gradeName FROM grades;
''';
  return _readQuery(database, query, (d) => GetAllGradesRow(d));
}

class GetAllGradesRow extends SqliteRow {
  GetAllGradesRow(super.data);

  int? get gradeid => data['gradeid'] as int?;
  String? get gradename => data['gradename'] as String?;
}

/// END GET ALL GRADES

/// BEGIN GET SUBJECTS IN GRADE
Future<List<GetSubjectsInGradeRow>> performGetSubjectsInGrade(
  Database database, {
  String? gradeId,
}) {
  final query = '''
SELECT s.subject_id as subjectId, s.subject_name  AS subjectName, sy.syllabus_id As syllabusId
FROM subjects s
JOIN syllabi sy ON s.subject_id = sy.subject_id
JOIN grades g ON sy.grade_id = g.grade_id
WHERE g.grade_id = $gradeId;

''';
  return _readQuery(database, query, (d) => GetSubjectsInGradeRow(d));
}

class GetSubjectsInGradeRow extends SqliteRow {
  GetSubjectsInGradeRow(super.data);

  int? get subjectId => data['subjectId'] as int?;
  String? get subjectName => data['subjectName'] as String?;
  int? get syllabusId => data['syllabusId'] as int?;
}

/// END GET SUBJECTS IN GRADE

/// BEGIN GET TOPICS IN SUBJECTS FROM SYLABI
Future<List<GetTopicsInSubjectsFromSylabiRow>>
    performGetTopicsInSubjectsFromSylabi(
  Database database, {
  int? syllabiId,
}) {
  final query = '''
SELECT t.topic_id AS topicId, t.topic_name as topicName
FROM topics t
JOIN syllabi sy ON t.syllabus_id = sy.syllabus_id
WHERE sy.syllabus_id = $syllabiId;
''';
  return _readQuery(
      database, query, (d) => GetTopicsInSubjectsFromSylabiRow(d));
}

class GetTopicsInSubjectsFromSylabiRow extends SqliteRow {
  GetTopicsInSubjectsFromSylabiRow(super.data);

  int? get topicId => data['topicId'] as int?;
  int? get topicName => data['topicName'] as int?;
}

/// END GET TOPICS IN SUBJECTS FROM SYLABI

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

/// BEGIN ALL LESSONS
Future<List<AllLessonsRow>> performAllLessons(
  Database database,
) {
  const query = '''
SELECT *
FROM lessons
WHERE status = 3;

''';
  return _readQuery(database, query, (d) => AllLessonsRow(d));
}

class AllLessonsRow extends SqliteRow {
  AllLessonsRow(super.data);
}

/// END ALL LESSONS

/// BEGIN GET SINGLE SYLLABI
Future<List<GetSingleSyllabiRow>> performGetSingleSyllabi(
  Database database, {
  int? syllabusId,
}) {
  final query = '''
SELECT
    g.grade_name AS gradeName,
    s.subject_name AS subjectName,
    sy.syllabus_id AS syllabusId
FROM syllabi sy
JOIN subjects s ON sy.subject_id = s.subject_id
JOIN grades g ON sy.grade_id = g.grade_id
WHERE sy.syllabus_id = $syllabusId;
''';
  return _readQuery(database, query, (d) => GetSingleSyllabiRow(d));
}

class GetSingleSyllabiRow extends SqliteRow {
  GetSingleSyllabiRow(super.data);

  String? get gradeName => data['gradeName'] as String?;
  String? get subjectName => data['subjectName'] as String?;
  int? get syllabusId => data['syllabusId'] as int?;
}

/// END GET SINGLE SYLLABI

/// BEGIN GET SUBTOPICS FROM TOPICID
Future<List<GetSubtopicsFromTopicIdRow>> performGetSubtopicsFromTopicId(
  Database database, {
  int? topicId,
}) {
  final query = '''
SELECT
    subtopic_id AS subtopicId,
    subtopic_name AS subtopicName,
    "order"
FROM subtopics
WHERE topic_id = $topicId
ORDER BY "order" ASC;

''';
  return _readQuery(database, query, (d) => GetSubtopicsFromTopicIdRow(d));
}

class GetSubtopicsFromTopicIdRow extends SqliteRow {
  GetSubtopicsFromTopicIdRow(super.data);

  String? get subtopicName => data['subtopicName'] as String?;
  int? get subtopicId => data['subtopicId'] as int?;
}

/// END GET SUBTOPICS FROM TOPICID
