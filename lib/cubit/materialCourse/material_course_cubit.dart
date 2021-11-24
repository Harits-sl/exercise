import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/models/material_course_model.dart';

part 'material_course_state.dart';

class MaterialCourseCubit extends Cubit<MaterialCourseState> {
  MaterialCourseCubit() : super(MaterialCourseInitial());

  void newMapMaterialCourse({
    required int id,
    required int idMateriBagian,
    required String idVideoMateri,
    required String namaMateri,
  }) {
    Map<String, dynamic> newMap = {
      'id': id,
      'idMateriBagian': idMateriBagian,
      'idVideoMateri': idVideoMateri,
      'namaMateri': namaMateri,
    };
    MaterialCourseModel data = MaterialCourseModel.fromMap(newMap);

    emit(MaterialCourseSuccess(data));
  }
}
