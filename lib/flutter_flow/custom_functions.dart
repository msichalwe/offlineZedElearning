import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';

List<dynamic>? getStringAndConvertToJsonArray(String? stringInput) {
  // get a string "[{},{}]" and convert it to json array
  if (stringInput == null) return null;
  try {
    final jsonArray = json.decode(stringInput);
    if (jsonArray is List<dynamic>) {
      return jsonArray;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

String? convertJsonPathToString(String? jsonPath) {
  // convert a json path $.path to a string
  if (jsonPath == null) {
    return null;
  }
  final pathList = jsonPath.split('.');
  final result = StringBuffer();
  for (final path in pathList) {
    if (path.startsWith('[') && path.endsWith(']')) {
      final index = int.tryParse(path.substring(1, path.length - 1));
      if (index != null) {
        result.write('[$index]');
      } else {
        return null;
      }
    } else {
      result.write('.$path');
    }
  }
  return result.toString().substring(1);
}
