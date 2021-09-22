import 'dart:convert';

import 'package:exercise/models/course_starter_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CourseStarterProvider with ChangeNotifier {
  final String baseUrl = 'https://bwasandbox.com';

  Future<dynamic> getAllCourseStarter() async {
    try {
      var apiResult = await http.get(Uri.parse('$baseUrl/api/course-starter'));

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
