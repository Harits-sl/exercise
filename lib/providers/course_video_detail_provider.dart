import 'dart:convert';

import 'package:exercise/models/course_video_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseVideoDetailProvider with ChangeNotifier {
  final String baseUrl = 'https://bwasandbox.com';

  Future<dynamic> getVideoDetail(int id) async {
    try {
      String url = '$baseUrl/api/course-starter/materi/$id';

      var apiResult = await http.get(Uri.parse(url));

      if (apiResult.statusCode == 200) {
        var data = jsonDecode(apiResult.body);
        CourseVideoDetailModel course = CourseVideoDetailModel.fromJson(data);

        return course;
      }
    } catch (e) {
      print(e);
    }
  }
}
