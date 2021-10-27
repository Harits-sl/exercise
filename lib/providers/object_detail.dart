import 'package:flutter/material.dart';

class ObjectDetailProvider with ChangeNotifier {
  var _objectDetail;

  get objectDetail => _objectDetail;

  set objectDetail(newLastCourse) {
    _objectDetail = newLastCourse;
    notifyListeners();
  }

  Map<String, dynamic> _materi = {
    'id': null,
    'namaMateri': null,
    'videoMateri': null,
  };

  Map<String, dynamic> get materi => _materi;

  set materi(Map<String, dynamic> newMateri) {
    _materi = newMateri;
    notifyListeners();
  }

  bool _isDone = false;

  bool get isDone => _isDone;

  set isDone(bool newValue) {
    _isDone = newValue;
    notifyListeners();
  }
}
