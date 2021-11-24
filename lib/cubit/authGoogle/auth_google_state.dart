part of 'auth_google_cubit.dart';

abstract class AuthGoogleState extends Equatable {
  const AuthGoogleState();

  @override
  List<Object> get props => [];
}

class AuthGoogleInitial extends AuthGoogleState {}

class AuthGoogleLoading extends AuthGoogleState {}

class AuthGoogleSuccess extends AuthGoogleState {
  final data;

  AuthGoogleSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AuthGoogleFailed extends AuthGoogleState {
  final String error;

  AuthGoogleFailed(this.error);

  @override
  List<Object> get props => [error];
}
