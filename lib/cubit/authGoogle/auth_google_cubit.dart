import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/repository/authGoogle/auth_google.dart';

part 'auth_google_state.dart';

class AuthGoogleCubit extends Cubit<AuthGoogleState> {
  AuthGoogleCubit() : super(AuthGoogleInitial());

  void googleSignIn() async {
    try {
      emit(AuthGoogleLoading());

      var signIn = await AuthGoogle().handleSignIn();

      emit(AuthGoogleSuccess(signIn));
    } catch (e) {
      print('err $e');
      emit(AuthGoogleFailed(e.toString()));
    }
  }

  void oAuthGoogleSignIn() async {
    try {
      emit(AuthGoogleLoading());

      var signIn = await AuthGoogle().handleSignInWithOauth();

      print('ini signin $signIn');

      emit(AuthGoogleSuccess(signIn));
    } catch (e) {
      print('err $e');
      emit(AuthGoogleFailed(e.toString()));
    }
  }
}
