import 'package:exercise/theme.dart';
import 'package:exercise/widgets/my_course.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              MyCourse(
                imageUrl: 'assets/course.jpg',
                title: 'Full-Stack Javascript',
              ),
              MyCourse(
                imageUrl: 'assets/course.jpg',
                title: 'Full-Stack Web',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
