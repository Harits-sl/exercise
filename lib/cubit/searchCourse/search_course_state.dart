part of 'search_course_cubit.dart';

abstract class SearchCourseState extends Equatable {
  const SearchCourseState();

  @override
  List<Object> get props => [];
}

class SearchCourseInitial extends SearchCourseState {}

class SearchCourseLoading extends SearchCourseState {}

class SearchCourseSuccess extends SearchCourseState {
  final List<SearchCourseModel> course;

  SearchCourseSuccess(this.course);

  @override
  List<Object> get props => [course];
}

class SearchCourseFailed extends SearchCourseState {
  final String error;

  SearchCourseFailed(this.error);

  @override
  List<Object> get props => [error];
}
