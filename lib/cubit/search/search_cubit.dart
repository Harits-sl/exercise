import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<int> {
  SearchCubit() : super(0);

  void setSearch(int newValue) {
    emit(newValue);
  }
}
