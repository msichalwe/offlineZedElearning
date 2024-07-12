import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  String? gradeName = '';
  int? gradeId = 0;
  String? subjectName = 'Dashboard';
  String? searchValue = '';

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _currentUserId = prefs.getString('ff_currentUserId') ?? _currentUserId;
    });
    _safeInit(() {
      _users = prefs
              .getStringList('ff_users')
              ?.map((x) {
                try {
                  return UsersStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _users;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _currentUserId = '';
  String get currentUserId => _currentUserId;
  set currentUserId(String value) {
    _currentUserId = value;
    prefs.setString('ff_currentUserId', value);
  }

  List<UsersStruct> _users = [];
  List<UsersStruct> get users => _users;
  set users(List<UsersStruct> value) {
    _users = value;
    prefs.setStringList('ff_users', value.map((x) => x.serialize()).toList());
  }

  void addToUsers(UsersStruct value) {
    _users.add(value);
    prefs.setStringList('ff_users', _users.map((x) => x.serialize()).toList());
  }

  void removeFromUsers(UsersStruct value) {
    _users.remove(value);
    prefs.setStringList('ff_users', _users.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromUsers(int index) {
    _users.removeAt(index);
    prefs.setStringList('ff_users', _users.map((x) => x.serialize()).toList());
  }

  void updateUsersAtIndex(
    int index,
    UsersStruct Function(UsersStruct) updateFn,
  ) {
    _users[index] = updateFn(_users[index]);
    prefs.setStringList('ff_users', _users.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInUsers(int index, UsersStruct value) {
    _users.insert(index, value);
    prefs.setStringList('ff_users', _users.map((x) => x.serialize()).toList());
  }

  UsersStruct _currentUser = UsersStruct.fromSerializableMap(jsonDecode(
      '{\"userName\":\"Mwansa Sichalwe\",\"userEmail\":\"yonasichalwe@gmail.com\",\"createdAt\":\"1712298540000\",\"updatedAt\":\"1712298540000\"}'));
  UsersStruct get currentUser => _currentUser;
  set currentUser(UsersStruct value) {
    _currentUser = value;
  }

  void updateCurrentUserStruct(Function(UsersStruct) updateFn) {
    updateFn(_currentUser);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
