import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise/models/user_model.dart';
import 'package:exercise/repository/database/user_db.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void getUser() async {
    try {
      emit(UserLoading());

      UserModel user = await UserDB.getUser();

      emit(UserSuccess(user));
    } catch (e) {}
  }

  void removeUser() async {
    try {
      emit(UserLoading());

      UserDB.removeUser();

      emit(UserRemove());
    } catch (e) {}
  }
}
