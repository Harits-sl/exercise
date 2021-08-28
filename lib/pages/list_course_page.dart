import 'package:exercise/theme.dart';
import 'package:flutter/material.dart';

class ListCoursePage extends StatelessWidget {
  String title;
  String totalVideo;

  ListCoursePage({required this.title, required this.totalVideo, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  'dadas',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
