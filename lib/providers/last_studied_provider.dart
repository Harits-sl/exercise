import 'package:exercise/models/course_detail_model.dart';
import 'package:flutter/material.dart';

class LastStudiedProvider with ChangeNotifier {
  var _lastCourse;

  get lastCourse => _lastCourse;

  set lastCourse(newLastCourse) {
    _lastCourse = newLastCourse;
    notifyListeners();
  }
}
