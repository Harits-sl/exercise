import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/models/search_course_model.dart';
import 'package:exercise/repository/api/search_course_api.dart';

part 'search_course_state.dart';

class SearchCourseCubit extends Cubit<SearchCourseState> {
  SearchCourseCubit() : super(SearchCourseInitial());

  void getSearchCourse(query) async {
    try {
      emit(SearchCourseLoading());
      List<SearchCourseModel> course =
          await SearchCourseApi().searchCourse(query);

      emit(SearchCourseSuccess(course));
    } catch (e) {
      emit(SearchCourseFailed(e.toString()));
    }
  }

  void resetSearchCourse() {
    emit(SearchCourseInitial());
  }
}
