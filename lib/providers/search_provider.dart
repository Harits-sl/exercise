import 'dart:convert';

import 'package:exercise/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<dynamic> searchCourse() async {
    try {
      var apiResult = await http.get(
          Uri.parse('https://bwasandbox.com/api/course-search?keyword=$query'));
      if (apiResult.statusCode == 200) {
        List data = jsonDecode(apiResult.body);
        print(data);
        List<SearchModel> listCourse =
            data.map((item) => SearchModel.fromJson(item)).toList();
        return listCourse;
      }
    } catch (e) {
      print(e);
    }
  }
}
