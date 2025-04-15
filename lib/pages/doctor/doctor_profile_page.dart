import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorProfileEditPage extends StatefulWidget {
  const DoctorProfileEditPage({super.key});

  @override
  State<DoctorProfileEditPage> createState() => _DoctorProfileEditPageState();
}

class _DoctorProfileEditPageState extends State<DoctorProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _specialityController = TextEditingController();
  final _experienceController = TextEditingController();
  final _aboutController = TextEditingController();
  final _feeController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDoctorProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specialityController.dispose();
    _experienceController.dispose();
    _aboutController.dispose();
    _feeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadDoctorProfile() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      // First try to get the profile
      final data = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      if (data != null) {
        setState(() {
          _nameController.text = data['full_name'] ?? '';
          _specialityController.text = data['speciality'] ?? '';
          _experienceController.text = data['experience'] ?? '';
          _aboutController.text = data['about'] ?? '';
          _feeController.text = data['fee']?.toString() ?? '';
          _addressController.text = data['address'] ?? '';
        });
      }
    } catch (e) {
      debugPrint('Error loading profile: $e');
      // If profile doesn't exist, we'll create it when saving
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      // Use upsert to either insert or update the profile
      await Supabase.instance.client.from('profiles').upsert({
        'id': user.id,
        'full_name': _nameController.text,
        'speciality': _specialityController.text,
        'experience': _experienceController.text,
        'about': _aboutController.text,
        'fee': double.tryParse(_feeController.text) ?? 0,
        'address': _addressController.text,
        'updated_at': DateTime.now().toIso8601String(),
        'role': 'doctor', // Add role to identify as doctor
      }).eq('id', user.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _isEditing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/images/logo.svg",
              width: 40,
              height: 25,
            ),
            const SizedBox(width: 8),
            if (!isSmallScreen) Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Doctor',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/doctor-login');
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
      // drawer: isSmallScreen ? _buildDrawer(context) : null,
      body: isSmallScreen
          ? _buildMobileBody()
          : _buildDesktopBody(),
    );
  }

  // Widget _buildDrawer(BuildContext context) {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       // children: [
  //       //   DrawerHeader(
  //       //     decoration: BoxDecoration(
  //       //       color: Colors.blue.shade50,
  //       //     ),
  //       //     child: Column(
  //       //       crossAxisAlignment: CrossAxisAlignment.start,
  //       //       children: [
  //       //         SvgPicture.asset(
  //       //           "assets/images/logo.svg",
  //       //           width: 40,
  //       //           height: 40,
  //       //         ),
  //       //         const SizedBox(height: 16),
  //       //         Container(
  //       //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //       //           decoration: BoxDecoration(
  //       //             color: Colors.blue.shade100,
  //       //             borderRadius: BorderRadius.circular(12),
  //       //           ),
  //       //           child: Text(
  //       //             'Doctor',
  //       //             style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //       //               color: Colors.blue,
  //       //             ),
  //       //           ),
  //       //         ),
  //       //       ],
  //       //     ),
  //       //   ),
  //       //   _buildNavItem(Icons.dashboard_outlined, 'Dashboard', context,
  //       //       '/doctor-dashboard', false),
  //       //   _buildNavItem(Icons.calendar_today_outlined, 'Appointments',
  //       //       context, '/doctor-appointments', false),
  //       //   _buildNavItem(Icons.person_outline, 'Profile', context,
  //       //       '/doctor-profile-edit', true),
  //       // ],
  //     ),
  //   );
  // }

  Widget _buildDesktopBody() {
    return Row(
      children: [
        // Navigation Drawer - fixed width sidebar
        Container(
          width: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              _buildNavItem(Icons.dashboard_outlined, 'Dashboard', context,
                  '/doctor-dashboard', false),
              _buildNavItem(Icons.calendar_today_outlined, 'Appointments',
                  context, '/doctor-appointments', false),
              _buildNavItem(Icons.person_outline, 'Profile', context,
                  '/doctor-profile-edit', true),
            ],
          ),
        ),
        // Main Content - expanded flexible area
        Expanded(
          child: _buildProfileContent(),
        ),
      ],
    );
  }

  Widget _buildMobileBody() {
    return _buildProfileContent();
  }

  Widget _buildProfileContent() {
    return Container(
      color: Colors.grey.shade50,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile header with responsive image
                    LayoutBuilder(
                        builder: (context, constraints) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              'assets/images/doc2.png',
                              width: constraints.maxWidth,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                    ),
                    // Profile content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and Edit button row - responsive
                          _buildNameEditRow(),
                          const SizedBox(height: 8),

                          // Speciality and Experience
                          _isEditing
                              ? _buildEditableSpecialityExperience()
                              : Text(
                            '${_specialityController.text}    •    ${_experienceController.text}YR',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // About section
                          const Text(
                            'About',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _isEditing
                              ? TextFormField(
                            controller: _aboutController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'About',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter about yourself';
                              }
                              return null;
                            },
                          )
                              : Text(
                            _aboutController.text,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Fee section
                          _buildFeeSection(),

                          const SizedBox(height: 16),

                          // Address section
                          Text(
                            'Address:',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          _isEditing
                              ? TextFormField(
                            controller: _addressController,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          )
                              : Text(
                            _addressController.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameEditRow() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return isSmallScreen
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isEditing
            ? TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        )
            : Text(
          _nameController.text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isEditing ? Colors.green : Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: _isLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white),
            )
                : Text(
              _isEditing ? 'Save Profile' : 'Edit Profile',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _isEditing
            ? SizedBox(
          width: 300,
          child: TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
        )
            : Text(
          _nameController.text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: _isLoading
              ? null
              : () {
            if (_isEditing) {
              _saveProfile();
            } else {
              setState(() {
                _isEditing = true;
              });
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: _isEditing
                ? Colors.green
                : Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: Colors.white),
          )
              : Text(
            _isEditing ? 'Save' : 'Edit Profile',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableSpecialityExperience() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return isSmallScreen
        ? Column(
      children: [
        TextFormField(
          controller: _specialityController,
          decoration: const InputDecoration(
            labelText: 'Speciality',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your speciality';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _experienceController,
          decoration: const InputDecoration(
            labelText: 'Experience (years)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    )
        : Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _specialityController,
            decoration: const InputDecoration(
              labelText: 'Speciality',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your speciality';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 150,
          child: TextFormField(
            controller: _experienceController,
            decoration: const InputDecoration(
              labelText: 'Experience (years)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildFeeSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return isSmallScreen
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment fee',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        _isEditing
            ? TextFormField(
          controller: _feeController,
          decoration: const InputDecoration(
            labelText: 'Fee',
            prefixText: '\$ ',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        )
            : Text(
          '\$ ${_feeController.text}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    )
        : Row(
      children: [
        Text(
          'Appointment fee',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 8),
        _isEditing
            ? SizedBox(
          width: 150,
          child: TextFormField(
            controller: _feeController,
            decoration: const InputDecoration(
              labelText: 'Fee',
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
        )
            : Text(
          '\$ ${_feeController.text}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
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
}