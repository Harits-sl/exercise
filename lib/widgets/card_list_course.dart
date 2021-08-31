import 'package:exercise/models/course.dart';
import 'package:exercise/widgets/list_course.dart';
import 'package:flutter/material.dart';

class CardListCourse extends StatelessWidget {
  final Map<String, dynamic> bagian;

  const CardListCourse({required this.bagian, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(bagian['nama_bagian']),
          ListCourse(
              courseTitle: bagian['nama_bagian']['materi_kelas'][0]
                  ['nama_materi']),
        ],
      ),
    );
  }
}
