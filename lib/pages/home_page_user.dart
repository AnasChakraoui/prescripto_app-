import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({Key? key}) : super(key: key);

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on selected index
    switch (index) {
      case 0: // Home
      // Already on home page
        break;
      case 1: // My Profile
        Navigator.pushNamed(context, '/user-profile');
        break;
      case 2: // My Appointments
        Navigator.pushNamed(context, '/appointments');
        break;
      case 3: // Logout
        Navigator.pushNamed(context, '/register');
        // Add your logout logic here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    final bool isDesktop = screenSize.width > 1200;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/images/logo.svg",
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            if (isDesktop || isTablet)
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('HOME', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/doctors');
                    },
                    child: const Text('ALL DOCTORS', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                    child: const Text('ABOUT', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/contact');
                    },
                    child: const Text('CONTACT', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
          ],
        ),
        actions: isDesktop || isTablet ? [
          // Only show user icon in app bar for tablet and desktop
          IconButton(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: const Icon(Icons.person, color: Colors.green),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/user-profile');
            },
          ),
        ] : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section - Responsive for different screen sizes
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: isDesktop ? 40 : 20
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: isDesktop || isTablet ?
              // Desktop/Tablet Layout
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildHeaderContent(),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/images/header_img.png',
                    width: isDesktop ? 600 : 400,
                    height: isDesktop ? 400 : 300,
                  ),
                ],
              ) :
              // Mobile Layout
              Column(
                children: [
                  _buildHeaderContent(),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/header_img.png',
                    width: screenSize.width * 0.8,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),

            // Find by Specialty Section
            const FindSpecialitySection(),

            // Top Doctors Section - Responsive grid
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Colors.grey[100],
              child: Column(
                children: [
                  const Text(
                    'Top Doctors to Book',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Simply browse through our extensive list of trusted doctors.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isDesktop ? 5 : (isTablet ? 3 : 2),
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: const [
                      DoctorCard(
                        name: 'Dr. Richard James',
                        specialty: 'General Practitioner',
                        image: 'assets/images/doc1.png',
                      ),
                      DoctorCard(
                        name: 'Dr. Christopher Davis',
                        specialty: 'General Practitioner',
                        image: 'assets/images/doc2.png',
                      ),
                      DoctorCard(
                        name: 'Dr. Chloe Evans',
                        specialty: 'General Practitioner',
                        image: 'assets/images/doc3.png',
                      ),
                      DoctorCard(
                        name: 'Dr. Sarah Wilson',
                        specialty: 'General Practitioner',
                        image: 'assets/images/doc4.png',
                      ),
                      DoctorCard(
                        name: 'Dr. Michael Brown',
                        specialty: 'General Practitioner',
                        image: 'assets/images/doc5.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/doctors');
                    },
                    child: const Text(
                      'More',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Section - Responsive layout
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              color: Colors.green,
              child: isDesktop || isTablet ?
              // Desktop/Tablet Layout
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: _buildBottomSectionContent(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/appointment_img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ) :
              // Mobile Layout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildBottomSectionContent(),
                    const SizedBox(height: 30),
                    Image.asset(
                      'assets/images/appointment_img.png',
                      fit: BoxFit.contain,
                      width: screenSize.width * 0.7,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: !isDesktop && !isTablet ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ) : null, // Don't show bottom nav on larger screens
    );
  }

  // Extracted header content for reuse
  Widget _buildHeaderContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Book Appointments With Trusted Doctors.',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Simply browse through our extensive list of trusted doctors, schedule your appointment hassle-free.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/doctors');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Book an appointment'),
        ),
      ],
    );
  }

  // Extracted bottom section content for reuse
  Widget _buildBottomSectionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Book Appointment With 100+ Trusted Doctors',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Access to medical consultations, vaccinations, birth control programs, and more.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Create Account'),
        ),
        const SizedBox(height: 30),
        const Text(
          'Contact us: info@prescripto.com | (613) 404-9428',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class FindSpecialitySection extends StatelessWidget {
  const FindSpecialitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    final bool isDesktop = screenSize.width > 1200;

    // Determine grid count based on screen size
    int crossAxisCount = isDesktop ? 6 : (isTablet ? 4 : 2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Find by Speciality',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Simply browse through our extensive list of trusted doctors, schedule your appointment hassle-free.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: specialties.length,
            itemBuilder: (context, index) {
              final specialty = specialties[index];
              return SpecialtyCard(
                iconPath: specialty['iconPath']!,
                title: specialty['title']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class SpecialtyCard extends StatelessWidget {
  final String iconPath;
  final String title;

  const SpecialtyCard({Key? key, required this.iconPath, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.blue[50], // Light blue color
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 50,
              height: 50,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String image;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  specialty,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Available',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
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

final List<Map<String, String>> specialties = [
  {'iconPath': 'assets/images/General_physician.svg', 'title': 'General Physician'},
  {'iconPath': 'assets/images/Gynecologist.svg', 'title': 'Gynecologist'},
  {'iconPath': 'assets/images/Dermatologist.svg', 'title': 'Dermatologist'},
  {'iconPath': 'assets/images/Pediatricians.svg', 'title': 'Pediatrician'},
  {'iconPath': 'assets/images/Neurologist.svg', 'title': 'Neurologist'},
  {'iconPath': 'assets/images/Gastroenterologist.svg', 'title': 'Gastroenterologist'},
];