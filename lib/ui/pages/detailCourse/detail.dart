import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import 'package:exercise/models/course_detail_model.dart';
import 'package:exercise/providers/youtube_id_provider.dart';

import '../../widgets/card_mentor.dart';
import '../../widgets/icon_star.dart';
import '../../../shared/theme.dart';
import '../../../helpers/string_helper.dart';

class Detail extends StatelessWidget {
  final CourseDetailModel data;

  const Detail({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var youtubeIdProvider = Provider.of<YoutubeIdProvider>(context);

    Widget header({
      required String namaKelas,
      required String tagline,
      required Map category,
      required num totalDuration,
      required num totalVideo,
      required int joinedAmount,
    }) {
      Widget text(String input) {
        return Text(
          '$input',
          style: primaryTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 12,
          ),
        );
      }

      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffE8EFFF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    category['name'],
                    style: blueTextStyle.copyWith(
                      color: Color(0xff2447F9),
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                text('$totalDuration Min'),
                SizedBox(
                  width: 6,
                ),
                text('•'),
                SizedBox(
                  width: 6,
                ),
                text('$totalVideo Lesson'),
                SizedBox(
                  width: 6,
                ),
                text('•'),
                SizedBox(
                  width: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconStar(),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '(${StringHelper.addComma(joinedAmount.toString())})',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              namaKelas,
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              tagline,
              style: primaryTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    Widget secondHeader(int joinedAmount, String levelKelas) {
      Widget richText(
          {bool isMember = false,
          required String title,
          required String subtitle}) {
        return Row(
          children: [
            SizedBox(
              width: defaultMargin,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '$title\n',
                style: primaryTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 12,
                  height: 1.7,
                ),
                children: [
                  TextSpan(
                    text: subtitle,
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: isMember ? ' enrolled' : '',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: defaultMargin,
            ),
            VerticalDivider(
              color: Color(0xffCCD8F5),
            ),
          ],
        );
      }

      return Container(
        height: 96,
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.symmetric(
          vertical: defaultMargin,
        ),
        color: Color(0xffE8EFFF),
        child: IntrinsicHeight(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              richText(
                  isMember: true,
                  title: 'Member',
                  subtitle:
                      '${StringHelper.addComma(joinedAmount.toString())}'),
              richText(title: 'Tingkatan', subtitle: levelKelas),
              richText(title: 'Sertifikat', subtitle: '-'),
              richText(title: 'Konsultasi', subtitle: '-'),
            ],
          ),
        ),
      );
    }

    Widget aboutCourse(String tentangKelas) {
      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About This Course',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
            Html(
              data: tentangKelas,
              style: {
                'body': Style(
                  margin: EdgeInsets.only(top: 12, bottom: 0),
                ),
                'p': Style.fromTextStyle(
                  primaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                    height: 1.7,
                  ),
                ),
              },
            ),
          ],
        ),
      );
    }

    Widget sectionItem(String name, int index, int lastIndex) {
      return Container(
        margin: EdgeInsets.only(
          bottom: lastIndex == index ? 0 : 12,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/icon_check.png',
              width: 18,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                name,
                style: primaryTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 12,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      );
    }

    Widget sectionCourse(String title, data) {
      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return sectionItem(
                  data[index],
                  index,
                  data.length - 1,
                );
              },
            ),
          ],
        ),
      );
    }

    Widget mentor(List authors) {
      return Container(
        padding: EdgeInsets.only(
          top: defaultMargin,
          bottom: defaultMargin + 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: defaultMargin,
              ),
              child: Text(
                'Learn With Expert',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              height: 185,
              child: ListView.builder(
                itemCount: authors.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: index == 0 ? defaultMargin : 12,
                      ),
                      CardMentor(author: authors[index]),
                      SizedBox(
                        width: index == authors.length - 1 ? defaultMargin : 0,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      num totalVideo = 0;
      num totalDuration = 0;

      var video = data.bagian
          .map((bagian) => bagian)
          .map((item) => totalVideo += item['materi_kelas'].length);

      var duration = data.bagian
          .map((bagian) => bagian)
          .map((item) => item['materi_kelas'])
          .map((item) {
        for (var i in item) {
          totalDuration += i['duration'];
        }
      });
      print(video);
      print(duration);
      youtubeIdProvider.youtubeId = data.trailerKelas;

      return Column(
        children: [
          header(
            namaKelas: data.namaKelas,
            tagline: data.tagline,
            category: data.category,
            totalDuration: totalDuration,
            totalVideo: totalVideo,
            joinedAmount: data.joinedAmount,
          ),
          secondHeader(data.joinedAmount, data.levelKelas),
          aboutCourse(data.tentangKelas),
          data.keyPoints.length == 0
              ? Container()
              : sectionCourse('Key Points', data.keyPoints),
          data.personas.length == 0
              ? Container()
              : sectionCourse('Designed For', data.personas),
          mentor(data.authors),
        ],
      );
    }

    return content();
  }
}
