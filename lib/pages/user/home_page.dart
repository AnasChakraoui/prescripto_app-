import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0: // Home
      // Already on home page
        break;
      case 1: // My Profile
        Navigator.pushNamed(context, '/doctors');
        break;
      case 2: // My Appointments
        Navigator.pushNamed(context, '/appointments');
        break;
      case 3: // Logout
        Navigator.pushNamed(context, '/about');
        // Add your logout logic here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size to determine layout
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: isMobile
            ? SvgPicture.asset(
          "assets/images/logo.svg",
          width: 40,
          height: 40,
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/images/logo.svg",
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 20),
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
        centerTitle: isMobile,
        actions: [
          // Create Account button moved to actions for both mobile and desktop
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
              ),
              child: const Text('Create Account'),
            ),
          ),
        ],
      ),
      drawer: isMobile
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Prescripto',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('HOME'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('ALL DOCTORS'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/doctors');
              },
            ),
            ListTile(
              title: const Text('ABOUT'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              title: const Text('CONTACT'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/contact');
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Create Account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: isMobile ? 20 : 40),
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: isMobile
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Book Appointments With Trusted Doctors.',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/header_img.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/group_profiles.png',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Simply browse through our extensive list of trusted doctors, schedule your appointment hassle-free.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/doctors');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Book an appointment'),
                    ),
                  ),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Book Appointments With Trusted Doctors.',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/group_profiles.png',
                              width: 110,
                              height: 110,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'Simply browse through our extensive list of trusted doctors, schedule your appointment hassle-free.',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/doctors');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Book an appointment'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/header_img.png', width: 600, height: 400),
                ],
              ),
            ),

            // Find by Specialty Section
            FindSpecialitySection(isMobile: isMobile),

            // Top Doctors Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: isMobile ? 10 : 20),
              color: Colors.grey[100],
              child: Column(
                children: [
                  const Text(
                    'Top Doctors to Book',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Simply browse through our extensive list of trusted doctors.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isMobile ? 2 : 5,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        name: 'Dr. Chloe Evans',
                        specialty: 'General Practitioner',
                        image: 'assets/images/doc4.png',
                      ),
                      DoctorCard(
                        name: 'Dr. Chloe Evans',
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

            // Bottom Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Stack(
                children: [
                  // Green background rectangle
                  Positioned.fill(
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                  // Content row
                  isMobile
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Book Appointment With 100+ Trusted Doctors',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/appointment_img.png',
                          width: 300,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Access to medical consultations, vaccinations, birth control programs, and more.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Create Account'),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Contact us: info@prescripto.com | (613) 404-9428',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                      : Row(
                    children: [
                      Expanded(
                        flex: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Book Appointment With 100+ Trusted Doctors',
                                style: TextStyle(
                                  fontSize: 36,
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('Create Account'),
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'Contact us: info@prescripto.com | (613) 404-9428',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/appointment_img.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              color: Colors.white24,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: isMobile ? 20 : 40),
              child: Column(
                children: [
                  isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'COMPANY',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Home', style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('About us', style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Delivery', style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Privacy policy', style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'GET IN TOUCH',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              '+1-423-4040-9628',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'newpresbioonegmed.com',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'COMPANY',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Home', style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('About us', style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Delivery', style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Privacy policy', style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GET IN TOUCH',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '+1-423-4040-9628',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'newpresbioonegmed.com',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'Copyright 2024 © Prescripto.com - All Rights Reserved.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Add bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class FindSpecialitySection extends StatelessWidget {
  final bool isMobile;

  const FindSpecialitySection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: isMobile ? 10 : 20),
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
              crossAxisCount: isMobile ? 2 : 6,
              childAspectRatio: 1,
              crossAxisSpacing: isMobile ? 10 : 50,
              mainAxisSpacing: isMobile ? 10 : 50,
            ),
            itemCount: specialties.length,
            itemBuilder: (context, index) {
              final specialty = specialties[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/doctors',
                    arguments: {'specialty': specialty['title']},
                  );
                },
                child: SpecialtyCard(
                  iconPath: specialty['iconPath']!,
                  title: specialty['title']!,
                  isMobile: isMobile,
                ),
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
  final bool isMobile;

  const SpecialtyCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: isMobile ? 60 : 90,
          height: isMobile ? 60 : 90,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: isMobile ? 50 : 90,
              height: isMobile ? 50 : 90,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w500,
          ),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  specialty,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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