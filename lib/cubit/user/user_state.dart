part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserRemove extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;

  UserSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserFailed extends UserState {}
