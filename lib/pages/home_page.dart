import 'package:exercise/providers/course_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/my_course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var courseProvider = Provider.of<CourseProvider>(context);

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
                  future: courseProvider.getAllCourseStarter(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
