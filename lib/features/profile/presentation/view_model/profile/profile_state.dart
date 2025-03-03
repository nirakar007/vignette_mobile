// part of 'profile_bloc.dart';

// import 'package:equatable/equatable.dart';
// import 'package:vignette__mobile/features/profile/presentation/view/profile_view.dart';

// sealed class ProfileState extends Equatable {
//   const ProfileState();

//   @override
//   List<Object> get props => [];
// }

// class ProfileInitial extends ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileLoadSuccess extends ProfileState {
//   final UserProfile profile;

//   const ProfileLoadSuccess(this.profile);

//   @override
//   List<Object> get props => [profile];
// }

// class ProfileLoadFailure extends ProfileState {
//   final String error;

//   const ProfileLoadFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }