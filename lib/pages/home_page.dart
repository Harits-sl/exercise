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

class _HomePageState extends State<HomePage> {
  int i = 0;
  int j = 3;
  int totalCourses = 0;

  @override
  Widget build(BuildContext context) {
    var courseProvider = Provider.of<CourseProvider>(context);

    var _getData = courseProvider.getAllCourseStarter(i, j);

    var a = [];
    for (var i = 1; i < (totalCourses / 3).round(); i++) {
      a.add(i);
    }
    print('ini a $a');
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
                      int i = data['totalCourses'];
                      totalCourses = i;
                      return Column(
                        children: data['someListCourses'].map<Widget>((item) {
                          return MyCourse(
                            course: item,
                          );
                        }).toList(),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // children: a.map<Widget>((page) {
                  //   setState(() {
                  //     i += 3;
                  //     j += 3;
                  //   });
                  //   return newMethod(_getData, courseProvider, page, i, j);
                  // }).toList(),
                  children: [
                    InkWell(
                      onTap: () {
                        if (i != 0 && j != 3) {
                          setState(() {
                            i -= 3;
                            j -= 3;
                            _getData = courseProvider.getAllCourseStarter(i, j);
                          });
                        }
                      },
                      child: Container(
                        color: i != 0 ? Colors.blue : Colors.white,
                        child: Icon(
                          Icons.arrow_left,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          i += 3;
                          j += 3;
                          _getData = courseProvider.getAllCourseStarter(i, j);
                        });
                      },
                      child: Container(
                        color: Colors.blue,
                        child: Icon(
                          Icons.arrow_right,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // newMethod(_getData, courseProvider, totalCourses),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell newMethod(Future<dynamic> _getData, CourseProvider courseProvider,
      int page, int start, int end) {
    // var a = [];
    // for (var i = 1; i < (totalCourses / 3).round(); i++) {
    //   a.add(i);
    // }
    // print(a);

    return InkWell(
      onTap: () {
        setState(() {
          _getData = courseProvider.getAllCourseStarter(start, end);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        color: Colors.blue,
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
