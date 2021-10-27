import 'package:exercise/helpers/string_helper.dart';
import 'package:exercise/pages/detail_course_page.dart';
import 'package:exercise/widgets/icon_star.dart';
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
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        print(course);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailCoursePage(
              id: course.id,
              trailerKelas: course.trailerKelas,
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
                        style: secondaryTextStyle.copyWith(
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
                    style: primaryTextStyle.copyWith(
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
                      IconStar(),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '(${StringHelper.addComma(course.joinedAmount.toString())})',
                        style: primaryTextStyle.copyWith(
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
