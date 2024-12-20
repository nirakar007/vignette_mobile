import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/screens/home_screen.dart';
import 'package:vignette__mobile/screens/new_board.dart';
import 'package:vignette__mobile/screens/user_boards.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0; // Keep track of the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const UserBoards(),
    const NewBoard()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/logo/logo.svg',
          width: 50,
          height: 50,
        ),
      ),
      body: lstBottomScreen[
          _selectedIndex], // Use the selected index to display the correct screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Boards',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
