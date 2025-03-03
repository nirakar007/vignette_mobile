// features/profile/domain/entities/user_profile.dart
class UserProfile {
  final String id;
  final String username;
  final String email;
  final String createdSince;
  final int boardsCount;
  final String? bio;
  final String? profilePicture;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.createdSince,
    required this.boardsCount,
    this.bio,
    this.profilePicture,
  });

  UserProfile copyWith({
    String? username,
    String? email,
    String? bio,
    String? profilePicture,
  }) {
    return UserProfile(
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdSince: createdSince,
      boardsCount: boardsCount,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      createdSince: json['createdSince'],
      boardsCount: json['boardsCount'],
      bio: json['bio'],
      profilePicture: json['profilePicture'],
    );
  }
}