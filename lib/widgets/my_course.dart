import 'package:exercise/models/course.dart';
import 'package:exercise/pages/list_course_page.dart';
import 'package:exercise/theme.dart';
import 'package:flutter/material.dart';

class MyCourse extends StatelessWidget {
  final Course? course;

  MyCourse({this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListCoursePage(
                  title: course!.namaKelas!,
                  totalVideo: '12,590',
                ),
              ),
            );
          },
          child: Image.network(
            'https://bwasandbox.com/${course!.thumbnailKelas!}',
          ),
        ),
        Text(
          course!.namaKelas ?? 'kosong',
          style: subTitleTextStyle,
        ),
      ],
    );
  }
}
