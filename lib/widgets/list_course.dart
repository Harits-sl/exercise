import 'package:exercise/pages/video_course_page.dart';
import 'package:flutter/material.dart';

class ListCourse extends StatelessWidget {
  final String courseTitle;
  final int id;
  final int lastCourseId;
  final List listCourseId;
  final String videoId;

  ListCourse(
      {required this.courseTitle,
      required this.id,
      required this.lastCourseId,
      required this.listCourseId,
      required this.videoId,
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
                  videoId: videoId,
                  id: id,
                  lastCourseId: lastCourseId,
                  listCourseId: listCourseId,
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
