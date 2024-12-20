import 'package:flutter/material.dart';

class UserBoards extends StatefulWidget {
  const UserBoards({super.key});

  @override
  State<UserBoards> createState() => _UserBoardsState();
}

class _UserBoardsState extends State<UserBoards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Boards"),
      ),
    );
  }
}