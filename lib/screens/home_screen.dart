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
  @override
  Widget build(BuildContext context) {
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment
                    .center, // Ensures the Row takes only needed space
                children: [
                  // premium card ad
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
                        const SizedBox(
                            height: 12), // Adds spacing between text and button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PremiumPurchaseScreen(), // Replace `TargetPage` with your desired page widget
                              ),
                            );
                            // Handle the "Learn More" button action
                            showMySnackBar(
                                context: context,
                                message: "learn more button pressed",
                                color: Colors.black);
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

                  const SizedBox(width: 30), // Spacing between text and image
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/images/home_screen/prem_ad.svg',
                      // 'assets/logo/logo.svg',
                      // 'assets/images/p1.jpg',
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
                  value:
                      selectedSortOption, // A variable to hold the selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSortOption = newValue!;
                      // Add logic to sort based on the selected value
                      if (selectedSortOption == 'Date') {
                        // Sort by date logic
                      } else if (selectedSortOption == 'Favourites') {
                        // Sort by favourites logic
                      }
                    });
                  },
                  items: <String>['Date', 'Favourites']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  underline: Container(), // Remove the default underline
                  icon: const Icon(Icons.sort), // Sort icon
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Handle the click event
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
            const Text(
              'Your desk is empty. Add a blank notebook or choose from templates.',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Grid of Cards
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // _buildCard(Icons.person, 'Personal Notebook'),
                // // _buildCard(Icons.article, 'Blog Post'),
                // _buildCard(Icons.lock, 'Secured Notes',),
                _buildCard(Icons.person, 'Personal Notebook',
                    const PersonalNotebook()),
                _buildCard(Icons.lock, 'Secured Notes', const SecuredNotes()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(IconData icon, String title, Widget targetPage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      borderRadius:
          BorderRadius.circular(12), // Ripple effect within rounded edges
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

  void main() => runApp(const MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ));
}
