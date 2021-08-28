import 'package:exercise/pages/list_course_page.dart';
import 'package:exercise/theme.dart';
import 'package:flutter/material.dart';

class MyCourse extends StatelessWidget {
  final String imageUrl;
  final String title;

  MyCourse({required this.imageUrl, required this.title, Key? key})
      : super(key: key);

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
                  title: title,
                  totalVideo: '12,590',
                ),
              ),
            );
          },
          child: Image.asset(
            imageUrl,
          ),
        ),
        Text(
          title,
          style: subTitleTextStyle,
        ),
      ],
    );
  }
}
