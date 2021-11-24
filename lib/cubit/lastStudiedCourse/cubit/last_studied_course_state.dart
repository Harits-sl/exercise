part of 'last_studied_course_cubit.dart';

abstract class LastStudiedCourseState extends Equatable {
  const LastStudiedCourseState();

  @override
  List<Object> get props => [];
}

class LastStudiedCourseInitial extends LastStudiedCourseState {}

class LastStudiedCourseSuccess extends LastStudiedCourseState {
  final LastStudiedCourseModel course;

  LastStudiedCourseSuccess(this.course);

  @override
  List<Object> get props => [course];
}
