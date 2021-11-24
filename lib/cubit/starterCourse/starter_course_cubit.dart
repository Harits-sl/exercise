import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/models/course_starter_model.dart';
import 'package:exercise/repository/api/starter_course_api.dart';

part 'starter_course_state.dart';

class FreeStarterCourseCubit extends Cubit<StarterCourseState> {
  FreeStarterCourseCubit() : super(StarterCourseInitial());

  void getNewFreeCourse() async {
    try {
      emit(StarterCourseLoading());

      List<CourseStarterModel> course =
          await StarterCourseApi().getAllFreeCourse();

      emit(StarterCourseSuccess(course));
    } catch (e) {
      emit(StarterCourseFailed(e.toString()));
    }
  }

  void resetFreeStarterCourse() {
    emit(StarterCourseInitial());
  }
}

class TopStarterCourseCubit extends Cubit<StarterCourseState> {
  TopStarterCourseCubit() : super(StarterCourseInitial());

  void getTopFeatured({bool isTake = false}) async {
    try {
      emit(StarterCourseLoading());

      List<CourseStarterModel> course =
          await StarterCourseApi().getAllTopFeatureCourse();

      emit(StarterCourseSuccess(course));
    } catch (e) {
      emit(StarterCourseFailed(e.toString()));
    }
  }

  void resetTopStarterCourse() {
    emit(StarterCourseInitial());
  }
}

class FreeStarterCourseForHomeCubit extends Cubit<StarterCourseState> {
  FreeStarterCourseForHomeCubit() : super(StarterCourseInitial());

  void getNewFreeCourse(int take) async {
    try {
      emit(StarterCourseLoading());

      List<CourseStarterModel> course =
          await StarterCourseApi().getAllFreeCourse(take: take.toString());

      emit(StarterCourseSuccess(course));
    } catch (e) {
      emit(StarterCourseFailed(e.toString()));
    }
  }
}

class TopStarterCourseForHomeCubit extends Cubit<StarterCourseState> {
  TopStarterCourseForHomeCubit() : super(StarterCourseInitial());

  void getTopFeatured(int take) async {
    try {
      emit(StarterCourseLoading());

      List<CourseStarterModel> course = await StarterCourseApi()
          .getAllTopFeatureCourse(take: take.toString());

      emit(StarterCourseSuccess(course));
    } catch (e) {
      emit(StarterCourseFailed(e.toString()));
    }
  }
}
