import 'package:exercise/cubit/lastStudiedCourse/cubit/last_studied_course_cubit.dart';
import 'package:exercise/cubit/search/search_cubit.dart';
import 'package:exercise/cubit/searchCourse/search_course_cubit.dart';
import 'package:exercise/cubit/starterCourse/starter_course_cubit.dart';
import 'package:exercise/firebase/crashlytics.dart';
import 'package:exercise/models/last_studied_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../materiKelas/materi_kelas_page.dart';
import '../search_page.dart';
import '../../widgets/card_course.dart';
import '../../widgets/category_item.dart';
import '../../widgets/navbar_item.dart';
import '../../../shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<FreeStarterCourseForHomeCubit>().getNewFreeCourse(2);
    context.read<TopStarterCourseForHomeCubit>().getTopFeatured(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          context.read<SearchCubit>().setSearch(0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          );
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

    Widget lastStudied() {
      return BlocBuilder<LastStudiedCourseCubit, LastStudiedCourseState>(
        builder: (context, state) {
          if (state is LastStudiedCourseSuccess) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MateriKelasPage(
                      listId: state.course.listId,
                      listMateri: state.course.listMateri,
                      listVideo: state.course.listIdVideo,
                      listIsExpanded: state.course.listIsExpanded,
                      listIsDone: state.course.listIsDone,
                      materiBagian: state.course.listMateriBagian,
                      index: state.course.index,
                      materi: state.course.materi,
                    ),
                  ),
                );
              },
              child: Container(
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
                        'https://bwasandbox.com${state.course.imageUrl}',
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
                            state.course.namaMateri,
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
              ),
            );
          }

          return SizedBox();
        },
      );
    }

    Widget course({required bool isNewFreeCourse}) {
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
                    isNewFreeCourse ? 'New Free Course' : 'Top Featured',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<SearchCubit>()
                          .setSearch(isNewFreeCourse ? 1 : 2);

                      isNewFreeCourse
                          ? context
                              .read<FreeStarterCourseCubit>()
                              .getNewFreeCourse()
                          : context
                              .read<TopStarterCourseCubit>()
                              .getTopFeatured();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                            isNewFreeCourse: isNewFreeCourse,
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
              child: isNewFreeCourse
                  ? BlocBuilder<FreeStarterCourseForHomeCubit,
                      StarterCourseState>(
                      builder: (context, state) {
                        if (state is StarterCourseLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is StarterCourseSuccess) {
                          int index = 0;

                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: state.course.map<Widget>((item) {
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
                          );
                        }
                        return SizedBox();
                      },
                    )
                  : BlocBuilder<TopStarterCourseForHomeCubit,
                      StarterCourseState>(
                      builder: (context, state) {
                        if (state is StarterCourseLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is StarterCourseSuccess) {
                          int index = 0;

                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: state.course.map<Widget>((item) {
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
                          );
                        }
                        return SizedBox();
                      },
                    ),
            ),
          ],
        ),
      );
    }

    Widget classCategory() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin, bottom: 72, // ditambah dengan tinggi navbar
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

    // Widget navbar() {
    //   return Container(
    //     color: whiteColor,
    //     height: 72,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         NavbarItem(
    //           imageUrl: 'assets/icon_home.png',
    //         ),
    //         NavbarItem(
    //           imageUrl: 'assets/icon_explore.png',
    //         ),
    //         NavbarItem(
    //           imageUrl: 'assets/icon_cart.png',
    //         ),
    //         NavbarItem(
    //           imageUrl: 'assets/icon_setting.png',
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: backgroundColor,
      // bottomNavigationBar: navbar(),
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            search(),
            lastStudied(),
            course(isNewFreeCourse: true),
            course(isNewFreeCourse: false),
            classCategory(),
          ],
        ),
      ),
    );
  }
}
