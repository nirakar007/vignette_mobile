part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeScreenLoaded extends HomeState {}

class NewBoardScreenLoaded extends HomeState {}

class UserBoardsScreenLoaded extends HomeState {}
