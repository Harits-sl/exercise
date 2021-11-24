import 'package:equatable/equatable.dart';

class MaterialCourseModel extends Equatable {
  final int id;
  final int idMateriBagian;
  final String idVideoMateri;
  final String namaMateri;

  MaterialCourseModel({
    required this.id,
    required this.idMateriBagian,
    required this.idVideoMateri,
    required this.namaMateri,
  });

  factory MaterialCourseModel.fromMap(Map<String, dynamic> map) {
    return MaterialCourseModel(
      id: map['id'] ?? 0,
      idMateriBagian: map['idMateriBagian'] ?? 0,
      idVideoMateri: map['idVideoMateri'] ?? '',
      namaMateri: map['namaMateri'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        idMateriBagian,
        idVideoMateri,
        namaMateri,
      ];
}
