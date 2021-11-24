part of 'starter_course_cubit.dart';

abstract class StarterCourseState extends Equatable {
  const StarterCourseState();

  @override
  List<Object> get props => [];
}

class StarterCourseInitial extends StarterCourseState {}

class StarterCourseLoading extends StarterCourseState {}

class StarterCourseSuccess extends StarterCourseState {
  final List<CourseStarterModel> course;

  StarterCourseSuccess(this.course);

  @override
  List<Object> get props => [course];
}

class StarterCourseFailed extends StarterCourseState {
  final String error;

  StarterCourseFailed(this.error);

  @override
  List<Object> get props => [error];
}
