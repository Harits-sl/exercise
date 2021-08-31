import 'dart:convert';

import 'package:exercise/models/course.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  final String baseUrl = '';

  Future getAllCourseStarter() async {
    String url = '';

    var apiResult = await http.get(Uri.parse(url));

    if (apiResult.statusCode == 200) {
      List data = jsonDecode(apiResult.body);

      List<Course> listCourses =
          data.map((item) => Course.fromJsonAllCourseStarter(item)).toList();

      return listCourses;
    }
  }
}
