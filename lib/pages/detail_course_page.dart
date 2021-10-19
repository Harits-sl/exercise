import 'dart:developer';

import 'package:exercise/helpers/string_helper.dart';
import 'package:exercise/pages/materi_video_page.dart';
import 'package:exercise/providers/last_studied_provider.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/providers/youtube_id_provider.dart';
import 'package:exercise/widgets/icon_star.dart';
import 'package:exercise/widgets/video_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:exercise/providers/course_detail_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/card_mentor.dart';

class DetailCoursePage extends StatelessWidget {
  final int id;

  const DetailCoursePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var courseDetailProvider = Provider.of<CourseDetailProivder>(context);
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);
    var youtubeIdProvider = Provider.of<YoutubeIdProvider>(context);

    Widget appBar() {
      return Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 24,
              ),
            ),
            Text(
              'Detail Course',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 24,
            ),
          ],
        ),
      );
    }

    Widget trailerVideo(String trailerKelas) {
      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: VideoCourse(youtubeId: trailerKelas),
        ),
      );
    }

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
                    style: GoogleFonts.poppins(
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

    Widget content(data) {
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
          trailerVideo(data.trailerKelas),
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

    Widget floatingActionButton(data) {
      List listCourseId = [];
      List listNamaMateri = [];
      List listVideoMateri = [];
      List listIsDone = [];
      List listIsExpanded = [];
      List l = [];

      return SizedBox(
        width: MediaQuery.of(context).size.width - (defaultMargin * 2),
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            objectDetailProvider.objectDetail = data;

            print(objectDetailProvider.objectDetail);

            void _addListId(value) {
              listCourseId.add(value);
            }

            void _addListMateri(value) {
              listNamaMateri.add(value);
            }

            void _addListVideo(value) {
              listVideoMateri.add(value);
            }

            void b(value) {
              l.add(value);
            }

            void _addListExpanded(value) {
              listIsExpanded.add(value);
            }

            void _addListDone(value) {
              listIsDone.add(value);
            }

            var id = data.bagian.map((item) => item).map((item) {
              for (var i = 0; i < item['materi_kelas'].length; i++) {
                _addListId(item['materi_kelas'][i]['id']);
              }
            });

            var namaMateri = data.bagian.map((item) => item).map((item) {
              for (var i = 0; i < item['materi_kelas'].length; i++) {
                _addListMateri(item['materi_kelas'][i]['nama_materi']);
              }
            });

            var videoMateri = data.bagian.map((item) => item).map((item) {
              for (var i = 0; i < item['materi_kelas'].length; i++) {
                _addListVideo(item['materi_kelas'][i]['video_materi']);
              }
            });

            var a = data.bagian.map((item) => item).map((item) {
              for (var i = 0; i < item['materi_kelas'].length; i++) {
                b(item['materi_kelas'][i]);
              }
            });
            print(a);
            print(id);
            print(namaMateri);
            print(videoMateri);

            for (var i = 0; i < data.bagian.length; i++) {
              _addListExpanded(true);
            }

            for (var i = 0; i < listCourseId.length; i++) {
              _addListDone(false);
            }

            objectDetailProvider.materi = {
              'id': listCourseId.first,
              'idMateriBagian': data.bagian[0]['materi_kelas'][0]
                  ['id_bagian_kelas'],
              'namaMateri': listNamaMateri.first,
              'videoMateri': listVideoMateri.first,
            };

            lastStudiedProvider.lastCourse = {
              'namaMateri': listNamaMateri.first,
              'listId': listCourseId,
              'listMateri': listNamaMateri,
              'listVideo': listVideoMateri,
              'listIsExpanded': listIsExpanded,
              'listIsDone': listIsDone,
              'materiBagian': l,
              'imageUrl': data.thumbnailKelas,
              'index': 0,
              'materi': data.bagian,
            };

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MateriVideoPage(
                  listId: listCourseId,
                  listMateri: listNamaMateri,
                  listVideo: listVideoMateri,
                  listIsExpanded: listIsExpanded,
                  listIsDone: listIsDone,
                  materiBagian: l,
                  materi: data.bagian,
                  index: 0,
                ),
              ),
            );
          },
          elevation: 0,
          label: Text(
            'Gabung Kelas',
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 14,
            ),
          ),
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
        ),
      );
    }

    Widget body() {
      return FutureBuilder(
        future: courseDetailProvider.getDetail(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                // ketika device landscape
                // hanya mengembalikan youtube video player
                if (orientation == Orientation.landscape) {
                  return VideoCourse(youtubeId: snapshot.data.trailerKelas);
                } else {
                  return Scaffold(
                    body: SafeArea(
                      bottom: false,
                      child: ListView(
                        children: [
                          appBar(),
                          content(snapshot.data),
                        ],
                      ),
                    ),
                    floatingActionButton: floatingActionButton(snapshot.data),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                  );
                }
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return Scaffold(
      body: body(),
    );
  }
}
