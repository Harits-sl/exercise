import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/my_course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

int i = 0;
int j = 3;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var courseProvider = Provider.of<CourseProvider>(context);
    var _getData = courseProvider.getAllCourseStarter(i, j);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'My Courses',
                    style: titleTextStyle,
                  ),
                ),
                FutureBuilder(
                  future: _getData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      int totalCourses = data['totalCourses'];

                      // array berisi objek banyaknya halaman
                      List arr = [];
                      // start dan end untuk parameter _getData
                      int start = 0;
                      int end = 3;
                      for (var i = 1; i < (totalCourses / 3).round(); i++) {
                        var obj = {
                          'page': i,
                          'start': start,
                          'end': end,
                        };
                        start += 3;
                        end += 3;
                        arr.add(obj);
                      }

                      return Column(
                        children: [
                          // widget tampilan kelas
                          Column(
                            children:
                                data['someListCourses'].map<Widget>((item) {
                              return MyCourse(
                                course: item,
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // widget tombol halaman
                          Container(
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: arr.map<Widget>((item) {
                                return pageButton(
                                  _getData,
                                  courseProvider,
                                  item['page'],
                                  item['start'],
                                  item['end'],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
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

  InkWell pageButton(Future<dynamic> _getData, CourseProvider courseProvider,
      int page, int start, int end) {
    return InkWell(
      onTap: () {
        setState(() {
          i = start;
          j = end;
          _getData = courseProvider.getAllCourseStarter(start, end);
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        color: i == start ? Colors.indigo[700] : Colors.lightBlueAccent,
        child: Text(
          page.toString(),
          style: subTitleTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
