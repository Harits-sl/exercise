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
                      return Column(
                        children: data.map<Widget>((item) {
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
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          i -= 3;
                          j -= 3;
                          _getData = courseProvider.getAllCourseStarter(i, j);
                        });
                      },
                      child: Container(
                        color: Colors.blue,
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
}
