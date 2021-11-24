part of 'detail_course_cubit.dart';

abstract class DetailCourseState extends Equatable {
  const DetailCourseState();

  @override
  List<Object> get props => [];
}

class DetailCourseInitial extends DetailCourseState {}

class DetailCourseLoading extends DetailCourseState {}

class DetailCourseSuccess extends DetailCourseState {
  final CourseDetailModel course;

  DetailCourseSuccess(this.course);

  @override
  List<Object> get props => [course];
}

class DetailCourseFailed extends DetailCourseState {
  final String error;

  DetailCourseFailed(this.error);

  @override
  List<Object> get props => [error];
}
