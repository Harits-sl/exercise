import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/card_list_course.dart';
import 'package:exercise/widgets/list_course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCoursePage extends StatelessWidget {
  final int id;
  final String title;
  final String totalVideo;

  ListCoursePage(
      {required this.title,
      required this.id,
      required this.totalVideo,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(title, style: titleTextStyle),
                      SizedBox(
                        height: 3,
                      ),
                      Text('$totalVideo Video', style: titleTextStyle),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // bagian warming up
                FutureBuilder(
                  future: courseProvider.getDetailCourseStarter(id.toString()),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      return ListView.builder(
                        itemCount: data.bagian.length,
                        itemBuilder: (context, position) {
                          return CardListCourse(bagian: data.bagian);
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
