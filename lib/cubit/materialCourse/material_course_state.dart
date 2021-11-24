part of 'material_course_cubit.dart';

abstract class MaterialCourseState extends Equatable {
  const MaterialCourseState();

  @override
  List<Object> get props => [];
}

class MaterialCourseInitial extends MaterialCourseState {}

class MaterialCourseSuccess extends MaterialCourseState {
  final MaterialCourseModel data;

  MaterialCourseSuccess(this.data);

  @override
  List<Object> get props => [data];
}
