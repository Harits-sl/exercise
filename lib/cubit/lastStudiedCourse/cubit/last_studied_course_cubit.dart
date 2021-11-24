import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/models/last_studied_course_model.dart';

part 'last_studied_course_state.dart';

class LastStudiedCourseCubit extends Cubit<LastStudiedCourseState> {
  LastStudiedCourseCubit() : super(LastStudiedCourseInitial());

  void newMapLastStudiedCourse({
    required int index,
    required String imageUrl,
    required String namaMateri,
    required List materi,
    required List listId,
    required List listMateri,
    required List listIdVideo,
    required List listIsExpanded,
    required List listIsDone,
    required List listMateriBagian,
  }) {
    Map<String, dynamic> newMap = {
      'index': index,
      'imageUrl': imageUrl,
      'namaMateri': namaMateri,
      'materi': materi,
      'listId': listId,
      'listMateri': listMateri,
      'listIdVideo': listIdVideo,
      'listIsExpanded': listIsExpanded,
      'listIsDone': listIsDone,
      'listMateriBagian': listMateriBagian,
    };

    LastStudiedCourseModel course = LastStudiedCourseModel.fromMap(newMap);

    emit(LastStudiedCourseSuccess(course));
  }
}
