import 'dart:convert';

import 'package:exercise/models/course.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  final String baseUrl = 'https://bwasandbox.com';

  Future getAllCourseStarter(int i, int j) async {
    String url = '$baseUrl/api/course-starter';

    var apiResult = await http.get(Uri.parse(url));

    if (apiResult.statusCode == 200) {
      List data = jsonDecode(apiResult.body);

      List<Course> listCourses =
          data.map((item) => Course.fromJson(item)).toList();

      int totalCourses = listCourses.length;
      // int b = 0;
      // int c = 0;
      // void a() {
      //   if (b < totalCourses) {
      //     b += 1;
      //     c += 3;
      //     print(b);
      //     if (c <= totalCourses) {
      //       a();
      //     }
      //   }
      //   return;
      // }

      // mengubah list kelas
      List someListCourses = listCourses.sublist(i, j);

      var obj = {
        'totalCourses': totalCourses,
        'someListCourses': someListCourses,
      };

      return obj;
    }
  }

  Future getDetailCourseStarter(String id) async {
    String url = '$baseUrl/api/course-starter/$id';

    var apiResult = await http.get(Uri.parse(url));

    if (apiResult.statusCode == 200) {
      var data = jsonDecode(apiResult.body);
      Course listCourses = Course.fromJson(data);

      return listCourses;
    }
  }

  Future getVideoCourseStarter(String id) async {
    String url = '$baseUrl/api/course-starter/materi/$id';

    var apiResult = await http.get(Uri.parse(url));

    if (apiResult.statusCode == 200) {
      var data = jsonDecode(apiResult.body);
      Course course = Course.fromJson(data);

      return course;
    }
  }
}
