import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../pages/home_page_user.dart';
import '../widgets/doctor_card.dart' hide DoctorCard;

class DoctorsListScreen extends StatefulWidget {
  @override
  _DoctorsListScreenState createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  String selectedSpecialty = 'All';
  String searchQuery = '';

  final List<String> specialties = [
    'All',
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Neurologist',
    'Orthopedic',
  ];

  final List<Doctor> doctors = [
    Doctor(
      id: 1,
      name: 'Dr. John Smith',
      specialty: 'Cardiologist',
      experience: '15 years',
      rating: 4.8,
      imageUrl: 'assets/images/doc1.png',
    ),
    // Add more doctors here
  ];

  List<Doctor> get filteredDoctors {
    return doctors.where((doctor) {
      final matchesSpecialty = selectedSpecialty == 'All' ||
          doctor.specialty == selectedSpecialty;
      final matchesSearch = doctor.name.toLowerCase().contains(
          searchQuery.toLowerCase()) ||
          doctor.specialty.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSpecialty && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Doctors'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search doctors...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedSpecialty,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Specialty',
                  ),
                  items: specialties.map((String specialty) {
                    return DropdownMenuItem(
                      value: specialty,
                      child: Text(specialty),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSpecialty = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return DoctorCard(
                  name: doctor.name,
                  specialty: doctor.specialty,
                  image: doctor.imageUrl,
                  // experience: doctor.experience,
                  // rating: doctor.rating,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}