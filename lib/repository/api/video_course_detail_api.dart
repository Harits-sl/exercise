import 'dart:convert';

import 'package:exercise/firebase/crashlytics.dart';
import 'package:exercise/models/course_video_detail_model.dart';
import 'package:http/http.dart' as http;

class VideoCourseDetailApi {
  Future<dynamic> getVideoDetail(int id) async {
    try {
      String url = 'https://bwasandbox.com/api/course-starter/materi/$id';

      var apiResult = await http.get(Uri.parse(url));

      if (apiResult.statusCode == 200) {
        var data = jsonDecode(apiResult.body);
        CourseVideoDetailModel course = CourseVideoDetailModel.fromJson(data);

        return course;
      }
    } catch (err, stackTrace) {
      print(err);
      Crashlytics.recordError(err, stackTrace, 'error in api');
    }
  }
}
