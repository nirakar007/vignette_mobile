import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/core/common/snackBar.dart';
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
    const NewBoard(),
    const UserBoards(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/logo/logo.svg',
              width: 35,
              height: 35,
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Handle the click event
                showMySnackBar(
                  context: context,
                  color: Colors.grey,
                  message: 'settings',
                );
              },
            ),
          ],
        ),
      ),
      body: lstBottomScreen[
          _selectedIndex], // Use the selected index to display the correct screen
      bottomNavigationBar: SnakeNavigationBar.color(
        snakeViewColor: Colors.black,
        // height: 260,
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 25,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              size: 25,
            ),
            label: 'Boards',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
