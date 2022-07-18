import 'package:auth_app/home_screen/response/response.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends HomeState {}

class WaitingState extends HomeState {}

class GetUserState extends HomeState {
  final CityData cityData;

  GetUserState({required this.cityData});

  @override
  List<Object?> get props => [cityData];
}

class FailureState extends HomeState {
  final String message;

  FailureState({required this.message});

  @override
  List<Object?> get props => [message];
}
