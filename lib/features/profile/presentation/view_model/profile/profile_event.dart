// part of 'profile_bloc.dart';

// import 'dart:io';

// import 'package:equatable/equatable.dart';

// sealed class ProfileEvent extends Equatable {
//   const ProfileEvent();

//   @override
//   List<Object> get props => [];
// }

// class ProfileLoad extends ProfileEvent {
//   final String userId;

//   const ProfileLoad(this.userId);

//   @override
//   List<Object> get props => [userId];
// }

// class ProfileUpdate extends ProfileEvent {
//   final String userId;
//   final String username;
//   final String email;
//   final String bio;

//   const ProfileUpdate({
//     required this.userId,
//     required this.username,
//     required this.email,
//     required this.bio,
//   });

//   @override
//   List<Object> get props => [userId, username, email, bio];
// }

// class ProfileImageUpload extends ProfileEvent {
//   final File file;

//   const ProfileImageUpload(this.file);

//   @override
//   List<Object> get props => [file];
// }