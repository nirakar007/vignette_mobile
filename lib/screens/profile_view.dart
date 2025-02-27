import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Profile', style: TextStyle(color: Colors.deepPurple)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.deepPurple),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const Divider(color: Colors.grey, height: 40),
            _buildStatsSection(),
            const SizedBox(height: 24),
            _buildMoreBoardsSection(),
            const SizedBox(height: 24),
            _buildDeskSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.deepPurple[100],
          child: const Icon(Icons.person, size: 30, color: Colors.deepPurple),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                )),
            Text('@johndoe', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('12', 'Boards'),
        _buildStatItem('2022', 'Member since'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            )),
        Text(label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            )),
      ],
    );
  }

  Widget _buildMoreBoardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('More Boards',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            )),
        const SizedBox(height: 8),
        Text('Have more boards to work on!, multiple times day.',
            style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const Text('Learn More',
              style: TextStyle(color: Colors.deepPurple)),
        ),
      ],
    );
  }

  Widget _buildDeskSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Desk',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            )),
        const SizedBox(height: 16),
        _buildFilterItem('Date: 10 | 12 | 2023 — 10 | 12 | 2023'),
        _buildFilterItem('Favourites'),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {},
              child: const Text('Apply'),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.chevron_right, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    // Implement logout logic
  }
}
