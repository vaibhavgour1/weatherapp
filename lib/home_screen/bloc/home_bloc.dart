import 'dart:async';
import 'dart:async';
import 'package:auth_app/home_screen/bloc/home_event.dart';
import 'package:auth_app/home_screen/bloc/home_state.dart';
import 'package:auth_app/home_screen/response/response.dart';
import 'package:auth_app/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<GetUserEvent>(getUser);
  }

  Future<void> getUser(GetUserEvent event, Emitter<HomeState> emit) async {
    emit(WaitingState());
    CityData response = await ApiService.fetchData();
    if (response.list!.isNotEmpty) {
      emit(GetUserState(cityData: response));
    } else {
      emit(FailureState(message: "Data not found!"));
    }
  }
}
