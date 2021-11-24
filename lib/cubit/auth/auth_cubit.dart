import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/models/auth_model.dart';
import 'package:exercise/repository/api/auth_api.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      var data = {'email': email, 'password': password};
      AuthModel auth = await AuthApi().signIn(data);

      emit(AuthSuccess(auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
