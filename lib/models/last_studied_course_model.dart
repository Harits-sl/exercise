import 'package:equatable/equatable.dart';

class LastStudiedCourseModel extends Equatable {
  final int index;
  final String imageUrl;
  final String namaMateri;
  final List materi;
  final List listId;
  final List listMateri;
  final List listIdVideo;
  final List listIsExpanded;
  final List listIsDone;
  final List listMateriBagian;

  LastStudiedCourseModel({
    required this.index,
    required this.imageUrl,
    required this.namaMateri,
    required this.materi,
    required this.listId,
    required this.listMateri,
    required this.listIdVideo,
    required this.listIsExpanded,
    required this.listIsDone,
    required this.listMateriBagian,
  });

  factory LastStudiedCourseModel.fromMap(Map<String, dynamic> map) {
    return LastStudiedCourseModel(
      index: map['index'],
      imageUrl: map['imageUrl'],
      namaMateri: map['namaMateri'],
      materi: List.from(map['materi']),
      listId: List.from(map['listId']),
      listMateri: List.from(map['listMateri']),
      listIdVideo: List.from(map['listIdVideo']),
      listIsExpanded: List.from(map['listIsExpanded']),
      listIsDone: List.from(map['listIsDone']),
      listMateriBagian: List.from(map['listMateriBagian']),
    );
  }

  @override
  List<Object?> get props => [
        index,
        imageUrl,
        namaMateri,
        materi,
        listId,
        listMateri,
        listIdVideo,
        listIsExpanded,
        listIsDone,
        listMateriBagian,
      ];
}
