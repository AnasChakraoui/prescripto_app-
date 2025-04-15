import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../screens/doctor_profile_page.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  String? _selectedSpecialty;
  final List<Map<String, String>> _doctors = [
    {
      'name': 'Richard James',
      'specialty': 'General Physician',
      'status': 'Available',
      'image': 'assets/images/doc1.png'
    },
    {
      'name': 'Dr. Christopher Davis',
      'specialty': 'General Physician',
      'status': 'Available',
      'image': 'assets/images/doc2.png'
    },
    {
      'name': 'Dr. Chloe Evans',
      'specialty': 'General Physician',
      'status': 'Available',
      'image': 'assets/images/doc3.png'
    },
    {
      'name': 'Dr. Emily Larson',
      'specialty': 'Dermatologist',
      'status': 'Available',
      'image': 'assets/images/doc4.png'
    },
    {
      'name': 'Dr. Timothy White',
      'specialty': 'Neurologist',
      'status': 'Available',
      'image': 'assets/images/doc5.png'
    },
    {
      'name': 'Dr. Ryan Martinez',
      'specialty': 'Gastroenterologist',
      'status': 'Available',
      'image': 'assets/images/doc6.png'
    },
    {
      'name': 'Dr. Sari Patel',
      'specialty': 'General physician',
      'status': 'Available',
      'image': 'assets/images/doc7.png'
    },
    {
      'name': 'Dr. Ava Mitchell',
      'specialty': 'Dermatologist',
      'status': 'Available',
      'image': 'assets/images/doc8.png'
    },
    {
      'name': 'Dr. Amelia Hill',
      'specialty': 'Neurologist',
      'status': 'Available',
      'image': 'assets/images/doc9.png'
    },
    {
      'name': 'Dr. Christopher Lee',
      'specialty': 'Pediatrician',
      'status': 'Available',
      'image': 'assets/images/doc10.png'
    },
    {
      'name': 'Dr. Jeffrey King',
      'specialty': 'Pediatrician',
      'status': 'Available',
      'image': 'assets/images/doc11.png'
    },
    {
      'name': 'Dr. Jennifer Garcia',
      'specialty': 'Neurologist',
      'status': 'Available',
      'image': 'assets/images/doc12.png'
    },
  ];

  final List<String> _specialties = [
    'General Physician',
    'Gynecologist',
    'Dermatologist',
    'Pediatrician',
    'Neurologist',
    'Gastroenterologist'
  ];

  void _filterDoctors(String? specialty) {
    setState(() {
      _selectedSpecialty = specialty;
    });
  }

  List<Map<String, String>> get _filteredDoctors {
    if (_selectedSpecialty == null) return _doctors;
    return _doctors.where((doctor) => doctor['specialty'] == _selectedSpecialty).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;
    final bool isDesktop = screenSize.width > 1200;

    // For mobile layout
    final bool isMobile = !isTablet && !isDesktop;

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/images/logo.svg",
          width: isMobile ? 40 : 50,
          height: isMobile ? 40 : 50,
        ),
        centerTitle: isMobile ? true : false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 10 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Browse through the doctors specialists',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 15),

            // Different layout for mobile vs desktop
            isMobile
                ? Column(
              children: [
                // Mobile specialty selector as horizontal scrollable list
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          label: Text('All'),
                          selected: _selectedSpecialty == null,
                          onSelected: (selected) {
                            if (selected) {
                              _filterDoctors(null);
                            }
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colors.green.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: _selectedSpecialty == null ? Colors.green : Colors.black,
                            fontWeight: _selectedSpecialty == null ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      ..._specialties.map((specialty) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FilterChip(
                          label: Text(specialty),
                          selected: _selectedSpecialty == specialty,
                          onSelected: (selected) {
                            if (selected) {
                              _filterDoctors(specialty);
                            } else {
                              _filterDoctors(null);
                            }
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colors.green.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: _selectedSpecialty == specialty ? Colors.green : Colors.black,
                            fontWeight: _selectedSpecialty == specialty ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      )).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // Doctor grid for mobile (2 columns)
                _filteredDoctors.isEmpty
                    ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('No doctors found in this specialty'),
                  ),
                )
                    : GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: _filteredDoctors
                      .map((doctor) => DoctorCard(
                    name: doctor['name']!,
                    specialty: doctor['specialty']!,
                    status: doctor['status']!,
                    image: doctor['image']!,
                  ))
                      .toList(),
                ),
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sidebar with specialties for desktop/tablet
                Container(
                  width: isTablet ? 180 : 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Specialties',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => _filterDoctors(null),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: _selectedSpecialty == null
                                  ? Colors.green
                                  : Colors.green.withOpacity(0.6),
                              fontWeight: _selectedSpecialty == null
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      ..._specialties.map((specialty) => InkWell(
                        onTap: () => _filterDoctors(specialty),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Text(
                            specialty,
                            style: TextStyle(
                              color: _selectedSpecialty == specialty
                                  ? Colors.green
                                  : Colors.green.withOpacity(0.6),
                              fontWeight: _selectedSpecialty == specialty
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      )).toList(),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Doctor grid for desktop/tablet
                Expanded(
                  child: _filteredDoctors.isEmpty
                      ? const Center(child: Text('No doctors found in this specialty'))
                      : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isDesktop ? 3 : 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: _filteredDoctors
                        .map((doctor) => DoctorCard(
                      name: doctor['name']!,
                      specialty: doctor['specialty']!,
                      status: doctor['status']!,
                      image: doctor['image']!,
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Bottom navigation for mobile
      bottomNavigationBar: isMobile ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
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
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/user-profile');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/appointments');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/register');
          }
        },
      ) : null,
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String status;
  final String image;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.status,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we're on a mobile device
    final bool isMobile = MediaQuery.of(context).size.width <= 600;

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorProfilePage(
                doctorName: name,
                specialty: specialty,
                imageUrl: image,
                appointmentFee: 50.0,
                about: 'Dr. $name is a highly qualified $specialty with extensive experience in treating patients.',
              ),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 8 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: status == 'Available' ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          color: status == 'Available' ? Colors.green : Colors.red,
                          fontSize: isMobile ? 10 : 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}