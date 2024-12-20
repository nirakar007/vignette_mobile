import 'package:flutter/material.dart';
import 'package:vignette__mobile/core/common/snackBar.dart';
import 'package:vignette__mobile/screens/personal_notebook.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Ensures the Row takes only needed space
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'More Boards',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Have more Boards to work on! Multiple times a day.',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Spacing between text and image
                  Flexible(
                    child: Image.asset(
                      'assets/images/home_screen/assetsimageshome_screenpersonal_note_illustration.png', // Your asset path
                      width: 80, // Set a fixed width
                      height: 80, // Set a fixed height
                      fit: BoxFit.cover,
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
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
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
