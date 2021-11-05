import 'dart:convert';

import 'package:exercise/firebase/crashlytics.dart';
import 'package:exercise/models/course_starter_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CourseStarterProvider with ChangeNotifier {
  Future<dynamic> getAllFreeCourse({String take = ''}) async {
    try {
      var apiResult = await http
          .get(Uri.parse('https://bwasandbox.com/api/course-free?take=$take'));

      if (apiResult.statusCode == 200) {
        List data = jsonDecode(apiResult.body);
        List<CourseStarterModel> listCourses =
            data.map((item) => CourseStarterModel.fromJson(item)).toList();

        return listCourses;
      }
    } catch (err, stackTrace) {
      print(err);
      Crashlytics.recordError(err, stackTrace, 'error in api');
    }
  }

  Future<dynamic> getAllTopFeatureCourse({String take = ''}) async {
    try {
      var apiResult = await http
          .get(Uri.parse('https://bwasandbox.com/api/course-top?take=$take'));

      if (apiResult.statusCode == 200) {
        List data = jsonDecode(apiResult.body);
        List<CourseStarterModel> listCourses =
            data.map((item) => CourseStarterModel.fromJson(item)).toList();

        return listCourses;
      }
    } catch (err, stackTrace) {
      print(err);
      Crashlytics.recordError(err, stackTrace, 'error in api');
    }
  }
}
