// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersStruct extends BaseStruct {
  UsersStruct({
    String? userName,
    String? userEmail,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avatar,
  })  : _userName = userName,
        _userEmail = userEmail,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _avatar = avatar;

  // "userName" field.
  String? _userName;
  String get userName => _userName ?? '';
  set userName(String? val) => _userName = val;
  bool hasUserName() => _userName != null;

  // "userEmail" field.
  String? _userEmail;
  String get userEmail => _userEmail ?? '';
  set userEmail(String? val) => _userEmail = val;
  bool hasUserEmail() => _userEmail != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;
  bool hasCreatedAt() => _createdAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? val) => _updatedAt = val;
  bool hasUpdatedAt() => _updatedAt != null;

  // "avatar" field.
  String? _avatar;
  String get avatar => _avatar ?? '';
  set avatar(String? val) => _avatar = val;
  bool hasAvatar() => _avatar != null;

  static UsersStruct fromMap(Map<String, dynamic> data) => UsersStruct(
        userName: data['userName'] as String?,
        userEmail: data['userEmail'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
        avatar: data['avatar'] as String?,
      );

  static UsersStruct? maybeFromMap(dynamic data) =>
      data is Map ? UsersStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'userName': _userName,
        'userEmail': _userEmail,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'avatar': _avatar,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userName': serializeParam(
          _userName,
          ParamType.String,
        ),
        'userEmail': serializeParam(
          _userEmail,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'updatedAt': serializeParam(
          _updatedAt,
          ParamType.DateTime,
        ),
        'avatar': serializeParam(
          _avatar,
          ParamType.String,
        ),
      }.withoutNulls;

  static UsersStruct fromSerializableMap(Map<String, dynamic> data) =>
      UsersStruct(
        userName: deserializeParam(
          data['userName'],
          ParamType.String,
          false,
        ),
        userEmail: deserializeParam(
          data['userEmail'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        updatedAt: deserializeParam(
          data['updatedAt'],
          ParamType.DateTime,
          false,
        ),
        avatar: deserializeParam(
          data['avatar'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UsersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UsersStruct &&
        userName == other.userName &&
        userEmail == other.userEmail &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        avatar == other.avatar;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userName, userEmail, createdAt, updatedAt, avatar]);
}

UsersStruct createUsersStruct({
  String? userName,
  String? userEmail,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? avatar,
}) =>
    UsersStruct(
      userName: userName,
      userEmail: userEmail,
      createdAt: createdAt,
      updatedAt: updatedAt,
      avatar: avatar,
    );
