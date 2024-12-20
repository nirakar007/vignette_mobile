import 'package:flutter/material.dart';

class UserBoards extends StatefulWidget {
  const UserBoards({super.key});

  @override
  State<UserBoards> createState() => _UserBoardsState();
}

class _UserBoardsState extends State<UserBoards> {
  final List<Map<String, dynamic>> boards = [
    {
      'title': 'My Journal',
      'icon': Icons.book,
      'lock': true,
      'favorite': true,
    },
    {
      'title': 'Biology',
      'icon': Icons.book,
      'lock': false,
      'favorite': false,
    },
    {
      'title': 'Daily Planner',
      'icon': Icons.book,
      'lock': false,
      'favorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desk"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add settings functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Desk",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: boards.length,
                itemBuilder: (context, index) {
                  final board = boards[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        board['icon'],
                        size: 36,
                      ),
                      title: Text(
                        board['title'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (board['lock'])
                            const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          const SizedBox(width: 8),
                          Icon(
                            board['favorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: board['favorite'] ? Colors.red : Colors.grey,
                          ),
                        ],
                      ),
                      onTap: () {
                        // Add functionality for tapping on the board
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for creating a new board
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
