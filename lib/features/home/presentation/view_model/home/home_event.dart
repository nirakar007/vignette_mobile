part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeScreen extends HomeEvent {}

class LoadNewBoardScreen extends HomeEvent {}

class LoadUserBoardsScreen extends HomeEvent {}
