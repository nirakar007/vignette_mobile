// // features/profile/presentation/view_model/profile_bloc/profile_bloc.dart
// import 'dart:io';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:vignette__mobile/features/auth/domain/use_case/upload_image_usecase.dart';
// import 'package:vignette__mobile/features/profile/data/model/user_profile_model.dart';
// import 'package:vignette__mobile/features/profile/domain/use_case/get_profile_usecase.dart';
// import 'package:vignette__mobile/features/profile/domain/use_case/update_profile_usecase.dart';

// part 'profile_event.dart';
// part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final GetProfileUseCase _getProfileUseCase;
//   final UpdateProfileUseCase _updateProfileUseCase;
//   final UploadImageUsecase _uploadImageUseCase;

//   ProfileBloc({
//     required GetProfileUseCase getProfileUseCase,
//     required UpdateProfileUseCase updateProfileUseCase,
//     required UploadImageUsecase uploadImageUseCase,
//   })  : _getProfileUseCase = getProfileUseCase,
//         _updateProfileUseCase = updateProfileUseCase,
//         _uploadImageUseCase = uploadImageUseCase,
//         super(ProfileInitial()) {
//     on<ProfileLoad>(_onProfileLoad);
//     on<ProfileUpdate>(_onProfileUpdate);
//     on<ProfileImageUpload>(_onProfileImageUpload);
//   }

//   Future<void> _onProfileLoad(
//     ProfileLoad event,
//     Emitter<ProfileState> emit,
//   ) async {
//     emit(ProfileLoading());
//     try {
//       final profile = await _getProfileUseCase(event.userId);
//       emit(ProfileLoadSuccess(profile));
//     } catch (e) {
//       emit(ProfileLoadFailure(e.toString()));
//     }
//   }

//   Future<void> _onProfileUpdate(
//     ProfileUpdate event,
//     Emitter<ProfileState> emit,
//   ) async {
//     if (state is ProfileLoadSuccess) {
//       final currentState = state as ProfileLoadSuccess;
//       emit(ProfileLoading());
//       try {
//         final updatedProfile = await _updateProfileUseCase(
//           UpdateProfileParams(
//             userId: event.userId,
//             username: event.username,
//             email: event.email,
//             bio: event.bio,
//             profilePicture: currentState.profile.profilePicture,
//           ),
//         );
//         emit(ProfileLoadSuccess(updatedProfile));
//       } catch (e) {
//         emit(ProfileLoadFailure(e.toString()));
//       }
//     }
//   }

//   Future<void> _onProfileImageUpload(
//     ProfileImageUpload event,
//     Emitter<ProfileState> emit,
//   ) async {
//     if (state is ProfileLoadSuccess) {
//       final currentState = state as ProfileLoadSuccess;
//       emit(ProfileLoading());
//       try {
//         final imageUrl = await _uploadImageUseCase(UploadImageParams(file: event.file));
//         final updatedProfile = currentState.profile.copyWith(profilePicture: imageUrl);
//         emit(ProfileLoadSuccess(updatedProfile));
//       } catch (e) {
//         emit(ProfileLoadFailure(e.toString()));
//       }
//     }
//   }
// }