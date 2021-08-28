import 'package:exercise/pages/video_course_page.dart';
import 'package:flutter/material.dart';

class ListCourse extends StatelessWidget {
  final String courseTitle;

  const ListCourse({required this.courseTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoCoursePage(
                  courseTitle: courseTitle,
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
            child: Text(
              courseTitle,
            ),
          ),
        ),
      ],
    );
  }
}
