import 'package:flutter/material.dart';

class NewBoard extends StatefulWidget {
  const NewBoard({super.key});

  @override
  State<NewBoard> createState() => _NewBoardState();
}

class _NewBoardState extends State<NewBoard> {
  String boardName = "New Board"; // Default board name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(boardName), // Display the board name on the app bar
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showNameDialog(context),
          child: const Text("Name Your Board"),
        ),
      ),
    );
  }

  // Pop-up dialog to name the board
  void _showNameDialog(BuildContext context) {
    String tempBoardName = ""; // Temporary variable to store input

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Board Name"),
          content: TextField(
            onChanged: (value) {
              tempBoardName = value;
            },
            decoration: const InputDecoration(
              hintText: "Type board name here...",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (tempBoardName.isNotEmpty) {
                  setState(() {
                    boardName = tempBoardName; // Update the board name
                  });
                }
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
