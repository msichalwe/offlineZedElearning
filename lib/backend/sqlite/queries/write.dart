import 'package:sqflite/sqflite.dart';

Future performCreateAssessmentGrade(
  Database database, {
  int? user_id,
  int? assessmentId,
  double? percentageScore,
  String? submittedAnswers,
  DateTime? createdAt,
}) {
  final query = '''
INSERT INTO `answers` (user_id, assessmentId, percentageScore, submittedAnswers, draganddrop_data)
VALUES ($user_id, $assessmentId, $percentageScore, $submittedAnswers, '[]');

''';
  return database.rawQuery(query);
}
