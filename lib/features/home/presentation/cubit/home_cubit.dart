import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());

    try {
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}