import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends HomeEvent {}

class GetCityEvent extends HomeEvent {
  final String city;
  GetCityEvent({required this.city});
  @override
  List<Object?> get props => [city];
}

// class AddHistoryDataEvent extends HomeEvent {}
