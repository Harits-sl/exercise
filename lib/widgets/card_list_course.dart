import 'package:exercise/theme.dart';
import 'package:exercise/widgets/list_course.dart';
import 'package:flutter/material.dart';

class CardListCourse extends StatelessWidget {
  final Map<String, dynamic> bagian;
  final int lastCourseId;

  const CardListCourse(
      {required this.bagian, required this.lastCourseId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bagian['nama_bagian'],
          style: subTitleTextStyle,
        ),
        SizedBox(height: 5),
        ListView.builder(
          itemCount: bagian['materi_kelas'].length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListCourse(
              id: bagian['materi_kelas'][index]['id'],
              courseTitle: bagian['materi_kelas'][index]['nama_materi'],
              lastCourseId: lastCourseId,
              // nextCourseTitle: bagian['materi_kelas'][index + 1]['nama_materi'],
              // nextVideoId: bagian['materi_kelas'][index + 1]['video_materi'],
            );
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
