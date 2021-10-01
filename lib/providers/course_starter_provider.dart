import 'dart:convert';

import 'package:exercise/models/course_starter_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CourseStarterProvider with ChangeNotifier {
  Future<dynamic> getAllFreeCourse() async {
    try {
      var apiResult =
          await http.get(Uri.parse('https://bwasandbox.com/api/course-free'));

      if (apiResult.statusCode == 200) {
        List data = jsonDecode(apiResult.body);
        List<CourseStarterModel> listCourses =
            data.map((item) => CourseStarterModel.fromJson(item)).toList();

        return listCourses;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getAllTopFeatureCourse() async {
    try {
      var apiResult =
          await http.get(Uri.parse('https://bwasandbox.com/api/course-top'));

      if (apiResult.statusCode == 200) {
        List data = jsonDecode(apiResult.body);
        List<CourseStarterModel> listCourses =
            data.map((item) => CourseStarterModel.fromJson(item)).toList();

        return listCourses;
      }
    } catch (e) {
      print(e);
    }
  }
}
