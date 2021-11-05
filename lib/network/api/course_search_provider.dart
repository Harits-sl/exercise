import 'dart:convert';

import 'package:exercise/firebase/crashlytics.dart';
import 'package:exercise/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseSearchProvider with ChangeNotifier {
  Future<dynamic> searchCourse(String query) async {
    try {
      var apiResult = await http.get(
          Uri.parse('https://bwasandbox.com/api/course-search?keyword=$query'));
      if (apiResult.statusCode == 200) {
        List data = jsonDecode(apiResult.body);
        List<SearchModel> listCourse =
            data.map((item) => SearchModel.fromJson(item)).toList();
        return listCourse;
      }
    } catch (err, stackTrace) {
      print(err);
      Crashlytics.recordError(err, stackTrace, 'error in api');
    }
  }
}
