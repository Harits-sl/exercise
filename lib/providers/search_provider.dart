import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  var _query;
  String get query => _query;

  set query(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }

  bool _isSearch = true;
  bool get isSearch => _isSearch;

  set isSearch(bool newValue) {
    _isSearch = newValue;
    notifyListeners();
  }
}
