import 'dart:convert';

import 'package:exercise/firebase/crashlytics.dart';
import 'package:exercise/models/course_detail_model.dart';
import 'package:http/http.dart' as http;

class DetailCourseApi {
  Future<dynamic> getDetail(int id) async {
    try {
      var apiResult = await http
          .get(Uri.parse('https://bwasandbox.com/api/course-starter/$id'));

      if (apiResult.statusCode == 200) {
        var data = jsonDecode(apiResult.body);
        CourseDetailModel course = CourseDetailModel.fromJson(data);
        return course;
      }
    } catch (err, stackTrace) {
      print(err);
      Crashlytics.recordError(err, stackTrace, 'error in api');
    }
  }
}
