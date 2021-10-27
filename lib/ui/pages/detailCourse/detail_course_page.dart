import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise/network/api/course_detail_provider.dart';
import './trailer_video.dart';

class DetailCoursePage extends StatelessWidget {
  final int id;
  final String trailerKelas;

  const DetailCoursePage({
    Key? key,
    required this.id,
    required this.trailerKelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var courseDetailProvider = Provider.of<CourseDetailProivder>(context);

    return Scaffold(
      body: FutureBuilder(
        future: courseDetailProvider.getDetail(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TrailerVideo(
              trailerKelas: trailerKelas,
              data: snapshot.data,
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
