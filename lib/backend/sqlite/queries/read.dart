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

  int? get gradeId => data['gradeId'] as int?;
  String? get gradeName => data['gradeName'] as String?;
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
  String? get topicName => data['topicName'] as String?;
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

/// BEGIN GET LESSONS FROM SUBTOPICS
Future<List<GetLessonsFromSubtopicsRow>> performGetLessonsFromSubtopics(
  Database database, {
  int? subtopicId,
}) {
  final query = '''
SELECT DISTINCT l.lesson_name AS lessonName, l.lesson_id AS lessonId
FROM lessons l
JOIN outcomes o ON l.outcome_id = o.outcome_id
JOIN subtopics st ON o.subtopic_id = st.subtopic_id
JOIN topics t ON st.topic_id = t.topic_id
JOIN syllabi sy ON t.syllabus_id = sy.syllabus_id
WHERE st.subtopic_id = $subtopicId
  AND l.status = 3
  AND l.deleted_at IS NULL
ORDER BY l.lesson_order ASC;
''';
  return _readQuery(database, query, (d) => GetLessonsFromSubtopicsRow(d));
}

class GetLessonsFromSubtopicsRow extends SqliteRow {
  GetLessonsFromSubtopicsRow(super.data);

  String? get lessonName => data['lessonName'] as String?;
  int? get lessonId => data['lessonId'] as int?;
}

/// END GET LESSONS FROM SUBTOPICS

/// BEGIN GET SINGLE LESSON
Future<List<GetSingleLessonRow>> performGetSingleLesson(
  Database database, {
  String? lessonId,
}) {
  final query = '''
SELECT 
    l.lesson_id as lessonId, 
    l.lesson_name as lessonName, 
    lp.lesson_phase_id as lessonPhaseId, 
    lpt.lesson_phase_types_name as lessonPhaseTypeName, 
    m.media_id as mediaId, 
    m.media_type as mediaType, 
    'https://zedelearning.chalotek.com/storage/' || m.media_url AS mediaUrl, 
    m.media_name as mdiaName, 
    m.text_position as textPosition, 
    m.media_description as mediaDescription, 
    t.text_content as textContent, 
    t.text_id as textId, 
    lp.tip as tip
FROM 
    lessons l
JOIN 
    lesson_phases lp ON l.lesson_id = lp.lesson_id
JOIN 
    lesson_phase_types lpt ON lp.lesson_phase_type_id = lpt.lesson_phase_type_id
LEFT JOIN 
    lesson_files lf ON lp.lesson_phase_id = lf.lesson_phase_id
LEFT JOIN 
    media m ON lf.media_id = m.media_id AND m.deleted_at IS NULL
LEFT JOIN 
    lesson_texts lt ON lp.lesson_phase_id = lt.lesson_phase_id
LEFT JOIN 
    texts t ON lt.text_id = t.text_id AND t.deleted_at IS NULL
WHERE 
    l.lesson_id = $lessonId
ORDER BY 
    lp.lesson_phase_id, m.media_id;

''';
  return _readQuery(database, query, (d) => GetSingleLessonRow(d));
}

class GetSingleLessonRow extends SqliteRow {
  GetSingleLessonRow(super.data);

  int? get lessonId => data['lessonId'] as int?;
  String? get lessonName => data['lessonName'] as String?;
  int? get lessonPhaseId => data['lessonPhaseId'] as int?;
  String? get lessonPhaseTypeName => data['lessonPhaseTypeName'] as String?;
  int? get mediaId => data['mediaId'] as int?;
  String? get mediaType => data['mediaType'] as String?;
  String? get mediaUrl => data['mediaUrl'] as String?;
  String? get mdiaName => data['mdiaName'] as String?;
  String? get textPosition => data['textPosition'] as String?;
  String? get mediaDescription => data['mediaDescription'] as String?;
  String? get textContent => data['textContent'] as String?;
  String? get tip => data['tip'] as String?;
  int? get textId => data['textId'] as int?;
}

/// END GET SINGLE LESSON

/// BEGIN GET SINGLE LESSON JSON
Future<List<GetSingleLessonJsonRow>> performGetSingleLessonJson(
  Database database, {
  int? lessonId,
}) {
  final query = '''
SELECT 
    json_object(
        'lessonId', l.lesson_id,
        'lessonName', l.lesson_name,
        'lessonPhases', (
            SELECT json_group_array(
                json_object(
                    'lessonPhaseId', lp.lesson_phase_id,
                    'lessonPhaseTypeName', lpt.lesson_phase_types_name,
                    'mediaFiles', (
                        SELECT json_group_array(
                            json_object(
                                'mediaId', m.media_id,
                                'mediaType', m.media_type,
                                'mediaUrl', 'https://yourdomain.com/storage/' || m.media_url,
                                'mediaName', m.media_name,
                                'textPosition', m.text_position,
                                'mediaDescription', m.media_description
                            )
                        )
                        FROM lesson_files lf
                        LEFT JOIN media m ON lf.media_id = m.media_id
                        WHERE lf.lesson_phase_id = lp.lesson_phase_id AND m.deleted_at IS NULL
                    ),
                    'textContent', t.text_content,
                    'textId', t.text_id,
                    'tip', lp.tip
                )
            )
            FROM lesson_phases lp
            LEFT JOIN lesson_phase_types lpt ON lp.lesson_phase_type_id = lpt.lesson_phase_type_id
            LEFT JOIN lesson_texts lt ON lp.lesson_phase_id = lt.lesson_phase_id
            LEFT JOIN texts t ON lt.text_id = t.text_id AND t.deleted_at IS NULL
            WHERE lp.lesson_id = l.lesson_id
        )
    )
as dataLesson FROM lessons l
WHERE l.lesson_id = $lessonId
GROUP BY l.lesson_id;
''';
  return _readQuery(database, query, (d) => GetSingleLessonJsonRow(d));
}

class GetSingleLessonJsonRow extends SqliteRow {
  GetSingleLessonJsonRow(super.data);

  dynamic get dataLesson => data['dataLesson'] as dynamic;
}

/// END GET SINGLE LESSON JSON

/// BEGIN GETSINGLELESSONCOLUMNS
Future<List<GetSingleLessonColumnsRow>> performGetSingleLessonColumns(
  Database database, {
  int? lessonId,
}) {
  final query = '''
SELECT 
    l.lesson_id AS lessonId, 
    l.lesson_name AS lessonName,
    (SELECT json_group_array(
        json_object(
            'lessonPhaseId', lp.lesson_phase_id,
            'lessonPhaseTypeName', lpt.lesson_phase_types_name,
            'mediaFiles', (
                SELECT json_group_array(
                    json_object(
                        'mediaId', m.media_id,
                        'mediaType', m.media_type,
                        'mediaUrl', 'https://zedelearning.chalotek.com/storage/' || m.media_url,
                        'mediaName', m.media_name,
                        'textPosition', m.text_position,
                        'mediaDescription', m.media_description
                    )
                )
                FROM lesson_files lf
                LEFT JOIN media m ON lf.media_id = m.media_id
                WHERE lf.lesson_phase_id = lp.lesson_phase_id AND m.deleted_at IS NULL
            ),
            'textContent', t.text_content,
            'textId', t.text_id,
            'tip', lp.tip
        )
    ) FROM lesson_phases lp
    LEFT JOIN lesson_phase_types lpt ON lp.lesson_phase_type_id = lpt.lesson_phase_type_id
    LEFT JOIN lesson_texts lt ON lp.lesson_phase_id = lt.lesson_phase_id
    LEFT JOIN texts t ON lt.text_id = t.text_id AND t.deleted_at IS NULL
    WHERE lp.lesson_id = l.lesson_id
    ) AS lessonPhases
FROM lessons l
WHERE l.lesson_id = $lessonId;

''';
  return _readQuery(database, query, (d) => GetSingleLessonColumnsRow(d));
}

class GetSingleLessonColumnsRow extends SqliteRow {
  GetSingleLessonColumnsRow(super.data);

  int? get lessonId => data['lessonId'] as int?;
  String? get lessonName => data['lessonName'] as String?;
  List<dynamic>? get lessonPhases => data['lessonPhases'] as List<dynamic>?;
}

/// END GETSINGLELESSONCOLUMNS

/// BEGIN GET PHASES FROM LESSON ID
Future<List<GetPhasesFromLessonIdRow>> performGetPhasesFromLessonId(
  Database database, {
  int? lessonId,
}) {
  final query = '''
SELECT 
    lp.lesson_phase_id AS lessonPhaseId, 
    lpt.lesson_phase_types_name AS lessonPhaseTypeName,
    (SELECT json_group_array(
        json_object(
            'mediaId', m.media_id,
            'mediaType', m.media_type,
            'mediaUrl', 'https://zedelearning.chalotek.com/storage/' || m.media_url,
            'mediaName', m.media_name,
            'textPosition', m.text_position,
            'mediaDescription', m.media_description
        )
    ) 
    FROM lesson_files lf
    LEFT JOIN media m ON lf.media_id = m.media_id
    WHERE lf.lesson_phase_id = lp.lesson_phase_id AND m.deleted_at IS NULL
    ) AS mediaFiles,
    t.text_content AS textContent,
    t.text_id AS textId,
    lp.tip AS tip
FROM lesson_phases lp
JOIN lesson_phase_types lpt ON lp.lesson_phase_type_id = lpt.lesson_phase_type_id
LEFT JOIN lesson_texts lt ON lp.lesson_phase_id = lt.lesson_phase_id
LEFT JOIN texts t ON lt.text_id = t.text_id AND t.deleted_at IS NULL
WHERE lp.lesson_id = $lessonId
ORDER BY lp.lesson_phase_id;

''';
  return _readQuery(database, query, (d) => GetPhasesFromLessonIdRow(d));
}

class GetPhasesFromLessonIdRow extends SqliteRow {
  GetPhasesFromLessonIdRow(super.data);

  int? get lessonPhaseId => data['lessonPhaseId'] as int?;
  String? get lessonPhaseTypeName => data['lessonPhaseTypeName'] as String?;
  String? get mediaFiles => data['mediaFiles'] as String?;
  String? get textContent => data['textContent'] as String?;
  int? get textId => data['textId'] as int?;
  String? get tip => data['tip'] as String?;
}

/// END GET PHASES FROM LESSON ID

////// Get Lesson Assessments

Future<List<GetLessonAssessmentsRow>> performGetLessonAssessments(
  Database database, {
  int? lessonAssessmentId,
}) {
  final query = '''
SELECT assessments.*
FROM assessments
JOIN lesson_assessments ON assessments.assessment_id = lesson_assessments.assessment_id
JOIN lesson_phases ON lesson_assessments.lesson_phase_id = lesson_phases.lesson_phase_id
JOIN lessons ON lesson_phases.lesson_id = lessons.lesson_id
WHERE lessons.lesson_id = $lessonAssessmentId;

''';
  return _readQuery(database, query, (d) => GetLessonAssessmentsRow(d));
}

class GetLessonAssessmentsRow extends SqliteRow {
  GetLessonAssessmentsRow(super.data);

  int? get assessmentId => data['assessment_id'] as int?;
  String? get assessmentName => data['assessment_name'] as String?;
  String? get assessmentDescription =>
      data['assessment_description'] as String?;
}

Future<List<LessonGradeCountRow>> performGetLessonGradeCount(Database database,
    {int? gradeId, String? subjectName}) async {
  var query = '''''';

  if (subjectName == 'Dashboard') {
    query = '''
    SELECT COUNT(*) AS total_lessons
FROM lessons
JOIN outcomes ON lessons.outcome_id = outcomes.outcome_id
JOIN subtopics ON outcomes.subtopic_id = subtopics.subtopic_id
JOIN topics ON subtopics.topic_id = topics.topic_id
JOIN syllabi ON topics.syllabus_id = syllabi.syllabus_id
WHERE syllabi.grade_id = $gradeId;
  ''';
  } else {
    query = '''
SELECT COUNT(DISTINCT l.lesson_id) AS total_lessons
FROM lessons l
         JOIN outcomes o ON l.outcome_id = o.outcome_id
         JOIN subtopics st ON o.subtopic_id = st.subtopic_id
         JOIN topics t ON st.topic_id = t.topic_id
         JOIN syllabi s ON t.syllabus_id = s.syllabus_id
         JOIN grades g ON s.grade_id = g.grade_id
         JOIN subjects sub ON s.subject_id = sub.subject_id
WHERE g.grade_id =$gradeId
  AND sub.subject_name = '$subjectName';
''';
  }

  return _readQuery(database, query, (d) => LessonGradeCountRow(d));
}

class LessonGradeCountRow extends SqliteRow {
  LessonGradeCountRow(super.data);

  String? get gradeName => data['grade_name'] as String?;
  int? get totalLessons => data['total_lessons'] as int?;
}

Future<List<AssessmentGradeCountRow>> performGetAssessmentGradeCount(
    Database database,
    {int? gradeId,
    String? subjectName}) async {
  var query = '''''';

  if (subjectName == 'Dashboard') {
    query = '''
SELECT 
    g.grade_name,
    COUNT(a.assessment_id) AS total_assessments
FROM 
    grades g
JOIN 
    syllabi s ON g.grade_id = s.grade_id
JOIN 
    topics t ON s.syllabus_id = t.syllabus_id
JOIN 
    subtopics st ON t.topic_id = st.topic_id
JOIN 
    outcomes o ON st.subtopic_id = o.subtopic_id
JOIN 
    lessons l ON o.outcome_id = l.outcome_id
JOIN 
    lesson_phases lp ON l.lesson_id = lp.lesson_id
JOIN 
    lesson_assessments la ON lp.lesson_phase_id = la.lesson_phase_id
JOIN 
    assessments a ON la.assessment_id = a.assessment_id
WHERE 
    g.grade_id = $gradeId
GROUP BY 
    g.grade_name;
  ''';
  } else {
    query = '''SELECT 
    COUNT(DISTINCT a.assessment_id) AS total_assessments
FROM 
    syllabi s
JOIN 
    subjects sub ON s.subject_id = sub.subject_id
JOIN 
    topics t ON s.syllabus_id = t.syllabus_id
JOIN 
    subtopics st ON t.topic_id = st.topic_id
JOIN 
    outcomes o ON st.subtopic_id = o.subtopic_id
JOIN 
    lessons l ON o.outcome_id = l.outcome_id
JOIN 
    lesson_phases lp ON l.lesson_id = lp.lesson_id
JOIN 
    lesson_assessments la ON lp.lesson_phase_id = la.lesson_phase_id
JOIN 
    assessments a ON la.assessment_id = a.assessment_id
WHERE 
    s.grade_id = $gradeId AND sub.subject_name = '$subjectName';''';
  }

  return _readQuery(database, query, (d) => AssessmentGradeCountRow(d));
}

class AssessmentGradeCountRow extends SqliteRow {
  AssessmentGradeCountRow(super.data);

  int? get totalAssessments => data['total_assessments'] as int?;
}

Future<List<SingleAssessmentRow>> performGetSingleAssessment(
  Database database, {
  int? assessmentId,
}) async {
  final query = '''
    SELECT *
FROM questions
WHERE assessment_id = $assessmentId;
  ''';

  return _readQuery(database, query, (d) => SingleAssessmentRow(d));
}

class SingleAssessmentRow extends SqliteRow {
  SingleAssessmentRow(super.data);

  String? get questionText => data['question_text'] as String?;
  String? get questionType => data['question_type'] as String?;
  String? get correctAnswer => data['correct_answer'] as String;
  String? get options => data['options'] as String?;
}

Future<List<SingleAssessmentGradeRow>> performGetSingleAssessmentGrade(
    Database database,
    {int? assessmentId,
    int? userId}) async {
  final query = '''
    SELECT *
FROM answers
WHERE assessmentId = $assessmentId AND user_id = $userId;
  ''';

  return _readQuery(database, query, (d) => SingleAssessmentGradeRow(d));
}

class SingleAssessmentGradeRow extends SqliteRow {
  SingleAssessmentGradeRow(super.data);

  int? get percentageScore => data['percentageScore'] as int?;
}
