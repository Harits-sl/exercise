import 'dart:convert';

import 'package:exercise/models/course_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseDetailProivder with ChangeNotifier {
  final String baseUrl = 'https://bwasandbox.com';

  Future<dynamic> getDetail(int id) async {
    try {
      var apiResult =
          await http.get(Uri.parse('$baseUrl/api/course-starter/$id'));

      if (apiResult.statusCode == 200) {
        var data = jsonDecode(apiResult.body);
        CourseDetailModel course = CourseDetailModel.fromJson(data);
        return course;
      }
    } catch (e) {
      print(e);
    }
  }
}
