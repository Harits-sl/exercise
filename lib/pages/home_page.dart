import 'package:exercise/providers/course_starter_provider.dart';
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
                  'Howdy, Bimo',
                  style: darkBlueTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Mau Belajar Apa Hari Ini?',
                  style: greyTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/profile.png',
              ),
            ),
          ],
        ),
      );
    }

    Widget search() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: TextField(
          style: darkBlueTextStyle.copyWith(
            fontWeight: regular,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Cari kelas yang ingin kamu pelajari',
            hintStyle: greyTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 12,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.all(12),
              child: Image.asset(
                'assets/icon_search.png',
                width: 24,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      );
    }

    Widget latestCourse() {
      return Container(
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
              child: Image.asset(
                'assets/latest_course.png',
                width: 60,
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
                    style: greyTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Full-Stack Laravel Flutter 2021: Building E-Commerce and Chat Apps',
                    style: darkBlueTextStyle.copyWith(
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

    Widget course(String title) {
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
                    title,
                    style: darkBlueTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Text(
                        'Lihat semua',
                        style: blueTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 10,
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
                  future: courseStarterProvider.getAllCourseStarter(),
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
                  }),
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
                style: darkBlueTextStyle.copyWith(
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
      backgroundColor: Color(0xffF6F8FD),
      bottomNavigationBar: navbar(),
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            search(),
            latestCourse(),
            course('New Free Course'),
            course('Top Featured'),
            classCategory(),
          ],
        ),
      ),
    );
  }
}
