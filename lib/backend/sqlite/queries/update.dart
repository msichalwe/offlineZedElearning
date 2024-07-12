import 'package:sqflite/sqflite.dart';

/// BEGIN CREATE LOCAL USER
Future performCreateLocalUser(
  Database database, {
  String? userName,
  String? userEmail,
  DateTime? createdAt,
}) {
  final query = '''
INSERT INTO `users` (name, email, created_at, updated_at)
VALUES ($userName, $userEmail,$createdAt,$createdAt);

''';
  return database.rawQuery(query);
}

/// END CREATE LOCAL USER

/// BEGIN UPDATE USER ACCOUNT NAME
Future performUpdateUserAccountName(
  Database database, {
  String? userName,
  String? currentId,
}) {
  final query = '''
UPDATE `users`
SET name = $userName
WHERE id = $currentId;

''';
  return database.rawQuery(query);
}

/// END UPDATE USER ACCOUNT NAME
