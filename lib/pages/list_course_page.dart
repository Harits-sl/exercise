import 'package:exercise/theme.dart';
import 'package:exercise/widgets/list_course.dart';
import 'package:flutter/material.dart';

class ListCoursePage extends StatelessWidget {
  final String title;
  final String totalVideo;

  ListCoursePage({required this.title, required this.totalVideo, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(title, style: titleTextStyle),
                      SizedBox(
                        height: 3,
                      ),
                      Text('$totalVideo Video', style: titleTextStyle),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListCourse(courseTitle: 'Install tools'),
                ListCourse(courseTitle: 'Download plugins'),
                ListCourse(courseTitle: 'Slicing templates'),
                ListCourse(courseTitle: 'Deploy server'),
                ListCourse(courseTitle: 'Penutup'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
