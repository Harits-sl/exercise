import 'package:exercise/helpers/string_helper.dart';
import 'package:exercise/pages/detail_course_page.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/icon_star.dart';
import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  final dynamic course;
  const SearchResultItem({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
      child: Container(
        margin: EdgeInsets.only(
          bottom: 12,
        ),
        padding: EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 12,
          right: 15,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://bwasandbox.com/${course.thumbnailKelas}',
                width: 62,
                height: 62,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
