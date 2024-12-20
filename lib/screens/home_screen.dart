import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/core/common/snackBar.dart';
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // Check if the device is a tablet

    return Scaffold(
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
                  // Premium card ad
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PremiumPurchaseScreen(),
                              ),
                            );
                            showMySnackBar(
                              context: context,
                              message: "Learn more button pressed",
                              color: Colors.black,
                            );
                          },
                          child: const Text(
                            'Learn More',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
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
                  'Desk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: selectedSortOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSortOption = newValue!;
                      // Add sorting logic here
                    });
                  },
                  items: <String>['Date', 'Favourites']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  underline: Container(),
                  icon: const Icon(Icons.sort),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showMySnackBar(
                      context: context,
                      color: Colors.grey,
                      message: 'Add notes',
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Search Bar
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
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
              crossAxisCount: isTablet ? 3 : 2, // Adjust columns for tablets
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (_matchesSearch('Personal Notebook'))
                  _buildCard(Icons.person, 'Personal Notebook',
                      const PersonalNotebook()),
                if (_matchesSearch('Secured Notes'))
                  _buildCard(Icons.lock, 'Secured Notes', const SecuredNotes()),
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
