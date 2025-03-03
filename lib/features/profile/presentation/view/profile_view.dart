import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // Add this package in pubspec.yaml

class ProfileView extends StatefulWidget {
  final String userId;
  const ProfileView({super.key, required this.userId});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserProfile? _profile;
   bool _isLoading = false;
  String? _errorMessage;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/v1/users/getMe/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _profile = UserProfile.fromJson(responseBody['data']['user']);
        });
      } else {
        throw HttpException(
            responseBody['message'] ?? 'Failed to load profile');
      }
    } on SocketException {
      setState(() {
        _errorMessage = 'No internet connection';
      });
    } on HttpException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_profile == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/v1/users/updateMe'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_AUTH_TOKEN', // Add actual auth
        },
        body: json.encode({
          'username': _profile!.username,
          'email': _profile!.email,
          'bio': _profile!.bio,
        }),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(responseBody['message'] ?? 'Update failed');
      }

      // Update local profile with server response
      setState(() {
        _profile = UserProfile.fromJson(responseBody['data']['user']);
      });
    } on HttpException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update profile';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  

  Future<void> _uploadImage(File image) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:5000/api/v1/users/updateProfilePicture'),
      )
        ..headers['Authorization'] = 'Bearer YOUR_AUTH_TOKEN' // Add actual auth
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final parsedJson = json.decode(responseBody);

      if (response.statusCode != 200) {
        throw HttpException(parsedJson['message'] ?? 'Image upload failed');
      }

      setState(() {
        _profile = _profile!.copyWith(
          profilePicture: parsedJson['data']['imageUrl'],
        );
      });
    } on SocketException {
      setState(() {
        _errorMessage = 'No internet connection';
      });
    } on HttpException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to upload image';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      await _uploadImage(_selectedImage!);
    }
  }

  // ... [Keep all existing methods from previous code up to build method] ...

  Widget _buildProfileContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _profile!.profilePicture != null
                        ? NetworkImage(_profile!.profilePicture!)
                        : _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : null,
                    child: _profile!.profilePicture == null &&
                            _selectedImage == null
                        ? const Icon(Icons.person,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                ),
              ),
            ),
          ),
          pinned: true,
          actions: [
            IconButton(
              onPressed: () => _showEditDialog(context),
              icon: const Icon(Icons.edit, color: Colors.white),
            )
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    _profile!.username,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Member since ${_profile!.createdSince}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildStatsCard(),
                  const SizedBox(height: 20),
                  _buildInfoSection(),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
                'Boards', _profile!.boardsCount.toString(), Icons.dashboard),
            _buildStatItem('Followers', '0', Icons.people),
            _buildStatItem('Following', '0', Icons.group),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blueAccent),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.email, color: Colors.blueAccent),
          title: const Text('Email'),
          subtitle: Text(
            _profile!.email,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.description, color: Colors.blueAccent),
          title: const Text('Bio'),
          subtitle: Text(
            _profile!.bio ?? 'No bio yet',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: _profile!.username);
    final TextEditingController emailController =
        TextEditingController(text: _profile!.email);
    final TextEditingController bioController =
        TextEditingController(text: _profile!.bio);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : _profile!.profilePicture != null
                                ? NetworkImage(_profile!.profilePicture!)
                                : null,
                        child: _selectedImage == null &&
                                _profile!.profilePicture == null
                            ? const Icon(Icons.camera_alt, size: 30)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: bioController,
                      decoration: const InputDecoration(labelText: 'Bio'),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _profile = _profile!.copyWith(
                      username: usernameController.text,
                      email: emailController.text,
                      bio: bioController.text,
                    );
                    _updateProfile();
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class UserProfile {
  final String username;
  final String email;
  final String createdSince;
  final int boardsCount;
  final String? bio;
  final String? profilePicture;

  UserProfile({
    required this.username,
    required this.email,
    required this.createdSince,
    required this.boardsCount,
    this.bio,
    this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        username: json['username'],
        email: json['email'],
        createdSince: json['createdSince'],
        boardsCount: json['boardsCount'],
        bio: json['bio'],
        profilePicture: json['profilePicture'],
      );

  UserProfile copyWith({
    String? username,
    String? email,
    String? bio,
    String? profilePicture,
  }) =>
      UserProfile(
        username: username ?? this.username,
        email: email ?? this.email,
        createdSince: createdSince,
        boardsCount: boardsCount,
        bio: bio ?? this.bio,
        profilePicture: profilePicture ?? this.profilePicture,
      );
}
