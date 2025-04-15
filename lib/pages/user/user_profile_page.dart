import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _emailController = TextEditingController(text: 'nouryredouane@gmail.com');
  final _phoneController = TextEditingController(text: '6134049428');
  final _addressController = TextEditingController(text: 'ottawa');
  final _genderController = TextEditingController(text: 'Male');
  final _birthdayController = TextEditingController(text: '1982-12-05');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/images/logo.svg",
          width: 40,
          height: 40,
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: const Icon(Icons.person, color: Colors.green),
            ),
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.pushNamed(context, '/user-profile');
              } else if (value == 'appointments') {
                Navigator.pushNamed(context, '/appointments');
              } else if (value == 'logout') {
                Navigator.pushNamed(context, '/register');
                // Handle logout logic
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('My Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'appointments',
                child: Text('My Appointments'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      // Bottom navigation for mobile
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.black,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'HOME',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.medical_services),
      //       label: 'DOCTORS',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.info),
      //       label: 'ABOUT',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.contact_mail),
      //       label: 'CONTACT',
      //     ),
      //   ],
      //   onTap: (index) {
      //     switch (index) {
      //       case 0:
      //         Navigator.pushNamed(context, '/');
      //         break;
      //       case 1:
      //         Navigator.pushNamed(context, '/doctors');
      //         break;
      //       case 2:
      //         Navigator.pushNamed(context, '/about');
      //         break;
      //       case 3:
      //         Navigator.pushNamed(context, '/contact');
      //         break;
      //     }
      //   },
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image and Name Section
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Redouane Noury',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Edit Button
                    ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          if (_formKey.currentState!.validate()) {
                            setState(() => isEditing = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile updated successfully')),
                            );
                          }
                        } else {
                          setState(() => isEditing = true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        isEditing ? 'Save' : 'Edit',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Information Sections
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('CONTACT INFORMATION'),
                    _buildInfoField('Email:', _emailController),
                    _buildInfoField('Phone:', _phoneController),
                    _buildInfoField('Address:', _addressController),
                    _buildSectionTitle('BASIC INFORMATION'),
                    _buildInfoField('Gender:', _genderController),
                    _buildInfoField('Birthday:', _birthdayController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          isEditing
              ? TextFormField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Field cannot be empty';
              if (label == 'Email:' && !value.contains('@')) {
                return 'Invalid email';
              }
              if (label == 'Phone:' && !RegExp(r'^\d+$').hasMatch(value)) {
                return 'Invalid phone';
              }
              return null;
            },
          )
              : Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              controller.text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }
}