import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/card_list_course.dart';
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
          physics: ScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: FutureBuilder(
              future: courseProvider.getDetailCourseStarter(id.toString()),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;

                  int totalVideo = 0;

                  void _addAndPrint(int number) {
                    totalVideo += number;
                  }

                  var a = data.bagian
                      .map((item) => item)
                      .map((item) => _addAndPrint(item['materi_kelas'].length));
                  print(a);

                  int lastIndex = data.bagian.length - 1;
                  print(data.bagian[lastIndex]);
                  return Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              data.namaKelas,
                              style: titleTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '$totalVideo Video',
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: data.bagian.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CardListCourse(bagian: data.bagian[index]);
                        },
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
