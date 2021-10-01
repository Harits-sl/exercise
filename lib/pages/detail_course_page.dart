import 'package:exercise/providers/youtube_id_provider.dart';
import 'package:exercise/utils/add_comma.dart';
import 'package:exercise/widgets/video_course.dart';
import 'package:flutter/material.dart';
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
    late String ids;
    var courseDetailProvider = Provider.of<CourseDetailProivder>(context);
    var youtubeIdProvider = Provider.of<YoutubeIdProvider>(context);
    List keyPoints = [
      'Mendalami tools di Figma',
      'Menggunakan Inspirasi Design',
      'Mendesain tampilan Landing',
      'Membuat Grid System'
    ];

    List designedFor = [
      'Anda yang ingin belajar Figma',
      'Anda yang ingin belajar layout',
      'Anda yang ingin design CTA lebih baik',
      'Anda yang ingin perdalam visual design'
    ];

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

    Widget header(String namaKelas, String tagline, Map category) {
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
                Text(
                  '41 Min • 10 Lesson',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
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

    Widget trailerVideo(String trailerKelas) {
      return Container(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: VideoCourse(youtubeId: trailerKelas),
            ),
          ],
        ),
      );
    }

    Widget secondHeader(int joinedAmount, String levelKelas) {
      return Container(
        margin: EdgeInsetsDirectional.only(
          top: defaultMargin,
        ),
        padding: EdgeInsetsDirectional.all(
          defaultMargin,
        ),
        color: Color(0xffE8EFFF),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Member\n',
                  style: primaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                    height: 1.7,
                  ),
                  children: [
                    TextSpan(
                      text: '${addComma(joinedAmount.toString())}',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: ' enrolled',
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Color(0xffCCD8F5),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Tingkatan\n',
                  style: primaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                    height: 1.7,
                  ),
                  children: [
                    TextSpan(
                      text: levelKelas,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Color(0xffCCD8F5),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Sertifikat\n',
                  style: primaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                    height: 1.7,
                  ),
                  children: [
                    TextSpan(
                      text: '-',
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
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
            SizedBox(
              height: 12,
            ),
            Text(
              // 'Landing Page sangatlah penting perannya di dalam sebuah website toko online, perusahaan, atau lainnya. Karena ia adalah halaman pertama yang akan dikunjungi oleh pengguna baru atau lama.\n\nOleh karena ini di Workshop Figma kali ini kita akan belajar mendesain sebuah Landing Page untuk kebutuhan website Charity (mengumpulkan dana bantuan) yang dapat memberikan pesan baik untuk donatur.',
              tentangKelas,
              style: primaryTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 12,
              ),
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
            Text(
              name,
              style: primaryTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    Widget sectionCourse(String title, bool isKeyPoints) {
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
            isKeyPoints
                ? ListView.builder(
                    itemCount: keyPoints.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return sectionItem(
                        keyPoints[index],
                        index,
                        keyPoints.length - 1,
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: designedFor.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return sectionItem(
                        designedFor[index],
                        index,
                        designedFor.length - 1,
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
      print(data.trailerKelas);
      youtubeIdProvider.youtubeId = data.trailerKelas;
      print(youtubeIdProvider.youtubeId);
      return Column(
        children: [
          trailerVideo(data.trailerKelas),
          header(data.namaKelas, data.tagline, data.category),
          secondHeader(data.joinedAmount, data.levelKelas),
          aboutCourse(data.tentangKelas),
          data.keyPoints.length == 0
              ? Container()
              : sectionCourse('Key Points', true),
          data.personas.length == 0
              ? Container()
              : sectionCourse('Designed For', false),
          mentor(data.authors),
        ],
      );
    }

    Widget floatingActionButton() {
      return SizedBox(
        width: MediaQuery.of(context).size.width - (defaultMargin * 2),
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ListCoursePage(
            //       id: course.id,
            //       title: course.namaKelas,
            //       totalVideo: '12,590',
            //     ),
            //   ),
            // );
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

    return Scaffold(
      body: FutureBuilder(
        future: courseDetailProvider.getDetail(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            print(data);
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                // ketika deevice landscape
                // hanya mengembalikan youtube video player
                if (orientation == Orientation.landscape) {
                  return VideoCourse(youtubeId: data.trailerKelas);
                } else {
                  return Scaffold(
                    body: SafeArea(
                      child: ListView(
                        children: [
                          appBar(),
                          content(data),
                        ],
                      ),
                    ),
                    floatingActionButton: floatingActionButton(),
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
      ),
    );
  }
}
