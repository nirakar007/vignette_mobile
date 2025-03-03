import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/features/home/presentation/view/home_view.dart';
import 'package:vignette__mobile/features/home/presentation/view_model/home/home_bloc.dart';
import 'package:vignette__mobile/screens/new_board.dart';
import 'package:vignette__mobile/screens/user_boards.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.read<HomeBloc>().add(LoadHomeScreen());
        break;
      case 1:
        context.read<HomeBloc>().add(LoadNewBoardScreen());
        break;
      case 2:
        context.read<HomeBloc>().add(LoadUserBoardsScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
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
                },
              ),
            ],
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeScreenLoaded) {
              return const HomeScreen();
            } else if (state is NewBoardScreenLoaded) {
              return const NewBoard();
            } else if (state is UserBoardsScreenLoaded) {
              return const UserBoards();
            }
            return Container(); // Default empty container
          },
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          snakeViewColor: Colors.black,
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
      ),
    );
  }
}
