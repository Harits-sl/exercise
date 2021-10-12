import 'package:exercise/pages/search_page.dart';
import 'package:exercise/providers/course_starter_provider.dart';
import 'package:exercise/providers/last_studied_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/card_course.dart';
import 'package:exercise/widgets/category_item.dart';
import 'package:exercise/widgets/navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var courseStarterProvider = Provider.of<CourseStarterProvider>(context);
    var lastStudiedProvider = Provider.of<LastStudiedProvider>(context);
    // method widget
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#SpiritOfLearning',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Mau Belajar Apa Hari Ini?',
                  style: secondaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/logo_bwa.png',
              ),
            ),
          ],
        ),
      );
    }

    Widget search() {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                isSearch: true,
              ),
            ),
          );

          // showSearch(
          //   context: context,
          //   delegate: CustomSearchDelegate(),
          // );
        },
        child: Container(
          height: 45,
          margin: EdgeInsets.only(
            top: defaultMargin,
            left: defaultMargin,
            right: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Image.asset(
                'assets/icon_search.png',
                width: 24,
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Text(
                  'Cari kelas yang ingin kamu pelajari',
                  style: secondaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget latestCourse() {
      return lastStudiedProvider.lastCourse == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
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
                      'https://bwasandbox.com${lastStudiedProvider.lastCourse['imageUrl']}',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terakhir yang kamu pelajari',
                          style: secondaryTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          lastStudiedProvider.lastCourse['namaMateri'],
                          style: primaryTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    }

    Widget course(bool isTopFeatured) {
      return Container(
        padding: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isTopFeatured ? 'Top Featured' : 'New Free Course',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                            isSearch: false,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Text(
                        'Lihat semua',
                        style: blueTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 212,
              child: FutureBuilder<dynamic>(
                future: isTopFeatured
                    ? courseStarterProvider.getAllTopFeatureCourse()
                    : courseStarterProvider.getAllFreeCourse(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    int index = 0;

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: data.sublist(0, 2).map<Widget>((item) {
                        index++;
                        return Container(
                          margin: EdgeInsets.only(
                            left: index == 1 ? defaultMargin : 14,
                            right: index == 2 ? defaultMargin : 0,
                          ),
                          child: CardCourse(
                            course: item,
                          ),
                        );
                      }).toList(),
                      // CardCourse(
                      //   course: data,
                      // ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget classCategory() {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Text(
                'Kategori Kelas',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 115,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 28,
                  ),
                  CategoryItem(
                    imageUrl: 'assets/icon_design.png',
                    name: 'Design',
                    totalCouse: 100,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  CategoryItem(
                    imageUrl: 'assets/icon_appcode.png',
                    name: 'Code',
                    totalCouse: 50,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  CategoryItem(
                    imageUrl: 'assets/icon_softskills.png',
                    name: 'Soft Skill',
                    totalCouse: 10,
                  ),
                  SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget navbar() {
      return Container(
        color: whiteColor,
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavbarItem(
              imageUrl: 'assets/icon_home.png',
            ),
            NavbarItem(
              imageUrl: 'assets/icon_explore.png',
            ),
            NavbarItem(
              imageUrl: 'assets/icon_cart.png',
            ),
            NavbarItem(
              imageUrl: 'assets/icon_setting.png',
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: navbar(),
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            search(),
            latestCourse(),
            course(false),
            course(true),
            classCategory(),
          ],
        ),
      ),
    );
  }
}
