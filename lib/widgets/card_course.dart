import 'package:exercise/pages/list_course_page.dart';
import 'package:flutter/material.dart';

import 'package:exercise/models/course_starter_model.dart';
import 'package:exercise/theme.dart';

class CardCourse extends StatelessWidget {
  final CourseStarterModel course;

  const CardCourse({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row iconStar() {
      return Row(
        children: [
          Image.asset(
            'assets/icon_star.png',
            width: 14,
          ),
          SizedBox(
            width: 1,
          ),
        ],
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListCoursePage(
              id: course.id,
              title: course.namaKelas,
              totalVideo: '12,590',
            ),
          ),
        );
      },
      child: Ink(
        width: 212,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                'https://bwasandbox.com/${course.thumbnailKelas}',
                width: 212,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 12,
                right: 22,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/profile_blank.png',
                        width: 13,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        course.authorKelas,
                        style: greyTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    course.namaKelas,
                    style: darkBlueTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      iconStar(),
                      iconStar(),
                      iconStar(),
                      iconStar(),
                      iconStar(),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '(${course.joinedAmount})',
                        style: darkBlueTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
