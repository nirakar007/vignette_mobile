import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:vignette__mobile/app/widget/showMySnackbar.dart';
import 'package:vignette__mobile/screens/personal_notebook.dart';
import 'package:vignette__mobile/screens/premium_purchase_screen.dart';
import 'package:vignette__mobile/screens/secured_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedSortOption = 'Date'; // Default sorting option
  String searchQuery = ''; // To store the search query
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: SvgPicture.asset('assets/logo/logo.svg', width: 50, height: 50),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: _buildNavigationDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "More Boards" Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'More Boards',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Have more Boards to work on! Multiple times a day.',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PremiumPurchaseScreen(),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Learn More'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/images/home_screen/prem_ad.svg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Desk Section
            Row(
              children: [
                const Text(
                  'Boards',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: selectedSortOption,
                  onChanged: (String? newValue) =>
                      setState(() => selectedSortOption = newValue!),
                  items: <String>['Date', 'Favourites'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  underline: Container(),
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Search Bar
            TextField(
              onChanged: (value) =>
                  setState(() => searchQuery = value.toLowerCase()),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search boards...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Grid of Cards
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: isTablet ? 3 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (_matchesSearch('Personal Notebook'))
                  _buildCard(Icons.book, 'Personal Notebook',
                      const PersonalNotebook()),
                if (_matchesSearch('Secured Notes'))
                  _buildCard(Icons.lock_outline, 'Secured Notes',
                      const SecuredNotes()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Search filtering
  bool _matchesSearch(String title) {
    return title.toLowerCase().contains(searchQuery);
  }

  Widget _buildCard(IconData icon, String title, Widget targetPage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNavigationDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.black),
              ),
              const SizedBox(height: 16),
              const Text(
                'Nirakar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'nirakar@example.com',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 14),
              ),
            ],
          ),
        ),
        ..._drawerMenuItems.map((item) => ListTile(
              leading: Icon(item.icon, color: Colors.black),
              title: Text(item.title),
              // onTap: () => _handleDrawerItemClick(item),
            )),
      ],
    ),
  );
}

void _handleDrawerItemClick(DrawerMenuItem item, BuildContext context) {
  Navigator.pop(context); // Close drawer
  switch (item.action) {
    case 'add':
      // Handle add notebook
      break;
    case 'favorite':
      // Handle favorites
      break;
    case 'export':
      // Handle export
      break;
    // case 'settings':
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => const AccountSettingsScreen()));
    //   break;
    case 'logout':
      // Handle logout
      break;
  }
}



class DrawerMenuItem {
  final String title;
  final IconData icon;
  final String action;

  DrawerMenuItem({
    required this.title,
    required this.icon,
    required this.action,
  });
}

final List<DrawerMenuItem> _drawerMenuItems = [
  DrawerMenuItem(title: 'Add notebook', icon: Icons.add, action: 'add'),
  DrawerMenuItem(
      title: 'Favourite', icon: Icons.favorite_border, action: 'favorite'),
  DrawerMenuItem(
      title: 'Export notebook', icon: Icons.upload, action: 'export'),
  DrawerMenuItem(
      title: 'Account settings', icon: Icons.settings, action: 'settings'),
  DrawerMenuItem(title: 'Log out', icon: Icons.logout, action: 'logout'),
];
