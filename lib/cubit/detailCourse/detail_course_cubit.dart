import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/models/course_detail_model.dart';
import 'package:exercise/repository/api/detail_course_api.dart';

part 'detail_course_state.dart';

class DetailCourseCubit extends Cubit<DetailCourseState> {
  DetailCourseCubit() : super(DetailCourseInitial());

  void getDetailCourse(id) async {
    try {
      emit(DetailCourseLoading());
      CourseDetailModel detailCourse = await DetailCourseApi().getDetail(id);

      emit(DetailCourseSuccess(detailCourse));
    } catch (e) {
      emit(DetailCourseFailed(e.toString()));
    }
  }
}
