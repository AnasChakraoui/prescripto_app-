import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DoctorsListPage extends StatelessWidget {
  const DoctorsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if device is mobile (narrow screen)
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/images/logo.svg",
              width: 32,
              height: 25,
            ),
            const SizedBox(width: 8),
            Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Admin',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/admin-login');
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      // Add drawer for mobile navigation
      // drawer: isMobile ? _buildNavigationDrawer(context) : null,
      body: isMobile
      // Mobile layout - just the content
          ? _buildContent(context)
      // Desktop layout - side nav + content
          : Row(
        children: [
          // Side Navigation
          Container(
            width: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            // child: _buildNavigationList(context),
          ),
          // Main Content
          Expanded(
            child: _buildContent(context),
          ),
        ],
      ),
      // Add bottom navigation for mobile
      // bottomNavigationBar: isMobile
      //     ? BottomNavigationBar(
      //   currentIndex: 3, // Doctors list is selected
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey.shade700,
      //   items: const [
      //     BottomNavigationBar.item(
      //       icon: Icon(Icons.dashboard_outlined),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBar.item(
      //       icon: Icon(Icons.calendar_today_outlined),
      //       label: 'Appointments',
      //     ),
      //     BottomNavigationBar.item(
      //       icon: Icon(Icons.person_add_outlined),
      //       label: 'Add Doctor',
      //     ),
      //     BottomNavigationBar.item(
      //       icon: Icon(Icons.people_outline),
      //       label: 'Doctors',
      //     ),
      //   ],
      //   onTap: (index) {
      //     final routes = [
      //       '/admin-dashboard',
      //       '/admin-appointments',
      //       '/add-doctor',
      //       '/doctors-list',
      //     ];
      //     Navigator.pushNamed(context, routes[index]);
      //   },
      // )
      //     : null,
    );
  }
  //
  // Widget _buildNavigationDrawer(BuildContext context) {
  //   return Drawer(
  //     child: _buildNavigationList(context),
  //   );
  // }

  // Widget _buildNavigationList(BuildContext context) {
  //   return ListView(
  //     padding: const EdgeInsets.symmetric(vertical: 16),
  //     children: [
  //       _buildNavItem(Icons.dashboard_outlined, 'Dashboard', context,
  //           '/admin-dashboard', false),
  //       _buildNavItem(Icons.calendar_today_outlined, 'Appointments', context,
  //           '/admin-appointments', false),
  //       _buildNavItem(Icons.person_add_outlined, 'Add Doctor', context,
  //           '/add-doctor', false),
  //       _buildNavItem(Icons.people_outline, 'Doctors List', context,
  //           '/doctors-list', true),
  //     ],
  //   );
  // }

  Widget _buildContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive grid columns based on screen width
    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 2; // Mobile: 2 columns
    } else if (screenWidth < 960) {
      crossAxisCount = 3; // Tablet: 3 columns
    } else if (screenWidth < 1280) {
      crossAxisCount = 4; // Small desktop: 4 columns
    } else {
      crossAxisCount = 6; // Large desktop: 6 columns
    }

    return Container(
      color: Colors.grey.shade50,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth < 600 ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Doctors',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: screenWidth < 600 ? 0.7 : 0.6,
              children: [
                _buildDoctorCard(
                  'Richard James',
                  'General physician',
                  'assets/images/doc1.png',
                ),
                _buildDoctorCard(
                  'Dr. Christopher Davis',
                  'General physician',
                  'assets/images/doc2.png',
                ),
                _buildDoctorCard(
                  'Dr. Chloe Evans',
                  'General physician',
                  'assets/images/doc3.png',
                ),
                _buildDoctorCard(
                  'Dr. Emily Larson',
                  'Gynecologist',
                  'assets/images/doc4.png',
                ),
                _buildDoctorCard(
                  'Dr. Timothy White',
                  'General physician',
                  'assets/images/doc5.png',
                ),
                _buildDoctorCard(
                  'Dr. Ryan Martinez',
                  'General physician',
                  'assets/images/doc6.png',
                ),
                _buildDoctorCard(
                  'Dr. Sari Patel',
                  'General physician',
                  'assets/images/doc7.png',
                ),
                _buildDoctorCard(
                  'Dr. Ava Mitchell',
                  'Dermatologist',
                  'assets/images/doc8.png',
                ),
                _buildDoctorCard(
                  'Dr. Amelia Hill',
                  'Neurologist',
                  'assets/images/doc9.png',
                ),
                _buildDoctorCard(
                  'Dr. Christopher Lee',
                  'Pediatrician',
                  'assets/images/doc10.png',
                ),
                _buildDoctorCard(
                  'Dr. Jeffrey King',
                  'Pediatrician',
                  'assets/images/doc11.png',
                ),
                _buildDoctorCard(
                  'Dr. Jennifer Garcia',
                  'Neurologist',
                  'assets/images/doc12.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, BuildContext context,
      String route, bool isSelected) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.grey.shade700,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.grey.shade700,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue.withOpacity(0.1),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildDoctorCard(String name, String specialty, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Available',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}