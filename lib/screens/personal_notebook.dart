import 'package:flutter/material.dart';

class PersonalNotebook extends StatefulWidget {
  const PersonalNotebook({super.key});

  @override
  State<PersonalNotebook> createState() => _PersonalNotebookState();
}

class _PersonalNotebookState extends State<PersonalNotebook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Notebook")),
      body: const Column(
        children: [
          Text("This is Personal notebook"),
        ],
      ),
    );
  }
}
