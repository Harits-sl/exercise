import 'package:exercise/cubit/detailCourse/detail_course_cubit.dart';
import 'package:exercise/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homePage/home_page.dart';
import '../../../shared/theme.dart';

class FinishCoursePage extends StatelessWidget {
  const FinishCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body() {
      void method() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }

      Widget content() {
        return BlocBuilder<DetailCourseCubit, DetailCourseState>(
          builder: (context, state) {
            if (state is DetailCourseSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image_finish.png',
                  ),
                  SizedBox(
                    height: 58,
                  ),
                  Text(
                    'What a Day!',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // TODO: perbaiki teks kelas
                  Text(
                    'kamu telah menyelesaikan kelas ${state.course.namaKelas} dengan sangat baik',
                    textAlign: TextAlign.center,
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    title: 'My Dashboard',
                    method: method,
                    borderRadius: 14,
                    color: blueColor,
                    textStyle: whiteTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        );
      }

      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SingleChildScrollView(
            child: content(),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: body(),
    );
  }
}
