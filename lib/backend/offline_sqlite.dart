import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'example5.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      create table answers
(
    answer_id        INTEGER    not null
        primary key autoincrement,
    user_id          bigint(20) not null
        ,
    assessmentId     bigint(20) not null
        ,
    percentageScore  decimal(5, 2),
    submittedAnswers BLOB,
    draganddrop_data longtext,
    created_at       timestamp,
    updated_at       timestamp
);
    ''');
  }

  Future<void> createGrade({
    required int userId,
    required int assessmentId,
    required double percentageScore,
    required  submittedAnswers,
  }) async {
    final db = await database;
    final String timestamp = DateTime.now().toIso8601String();


    // Check if the record already exists
    final List<Map<String, dynamic>> existingRecords = await db.query(
      'answers',
      where: 'user_id = ? AND assessmentId = ?',
      whereArgs: [userId, assessmentId],
    );

    if (existingRecords.isEmpty) {
      // Insert new record if it doesn't exist
      await db.insert('answers', {
        'user_id': userId,
        'assessmentId': assessmentId,
        'percentageScore': percentageScore,
        'submittedAnswers': submittedAnswers,
      });
    } else {
      // Update existing record
      await db.update(
        'answers',
        {
          'percentageScore': percentageScore,
          'submittedAnswers': submittedAnswers,
          // 'updatedAt': timestamp,
        },
        where: 'user_id = ? AND assessmentId = ?',
        whereArgs: [userId, assessmentId],
      );
    }
  }

  Future<void> insertAssessmentProgress(Map<String, dynamic> progress) async {
    final db = await database;
    await db.insert('answers', progress);
  }

  Future<List<Map<String, dynamic>>> fetchAssessmentProgresses() async {
    final db = await database;
    return await db.query('answers');
  }

  Future<void> updateAssessmentProgress(Map<String, dynamic> progress) async {
    final db = await database;
    await db.update('answers', progress, where: 'user_id = ?', whereArgs: [progress['user_id']]);
  }

  Future<void> deleteAssessmentProgress(int userId) async {
    final db = await database;
    await db.delete('answers', where: 'user_id = ?', whereArgs: [userId]);
  }

  // Method to count all answers for a given user ID
  Future<int> countUserAnswers(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM answers WHERE user_id = ?',
        [userId]
    );
    return int.parse(result.first['count'].toString());
  }

  // Method to count all answers with a percentage score greater than 50
  Future<int> countUserAnswersAbove50(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM answers WHERE user_id = ? AND percentageScore >= 50',
        [userId]
    );
    return int.parse(result.first['count'].toString());
  }


  // Method to fetch a specific record by userId and assessmentId
  Future<Map<String, dynamic>?> fetchSpecificRecord(int userId, int assessmentId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
        'answers',
        where: 'user_id = ? AND assessmentId = ?',
        whereArgs: [userId, assessmentId],
        limit: 1
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;  // Return null if no record is found
    }
  }

  Future<Map<String, dynamic>?> fetchAllResults(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
        'answers',
        where: 'user_id = ?',
        whereArgs: [userId],
        limit: 1
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;  // Return null if no record is found
    }
  }


  Future<Map<String, dynamic>?> fetchResults(int userId, int assessmentId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
        'answers',
        where: 'user_id = ? AND assessmentId = ?',
        whereArgs: [userId, assessmentId],
        limit: 1
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;  // Return null if no record is found
    }
  }
}