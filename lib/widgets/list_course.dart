import 'package:exercise/pages/video_course_page.dart';
import 'package:flutter/material.dart';

class ListCourse extends StatelessWidget {
  final String courseTitle;
  final int id;
  // final String videoId;
  // final String nextVideoId;
  // final String nextCourseTitle;

  const ListCourse(
      {required this.courseTitle,
      required this.id,
      // required this.videoId,
      // required this.nextVideoId,
      // required this.nextCourseTitle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoCoursePage(
                  // videoId: videoId,
                  // courseTitle: courseTitle,
                  // nextVideoId: nextVideoId,
                  // nextCourseTitle: nextCourseTitle,
                  id: id,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  courseTitle,
                ),
                Icon(
                  Icons.play_arrow,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
