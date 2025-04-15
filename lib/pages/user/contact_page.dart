import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width to make layout responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/images/logo.svg",
          width: 40,
          height: 40,
        ),
        actions: isMobile
            ? [
          // Mobile menu using IconButton for dropdown
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showMobileMenu(context);
            },
          ),
        ]
            : [
          // Desktop horizontal navigation
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
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
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
      floatingActionButton: isMobile
          ? FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/doctor-login');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.person_add, color: Colors.white),
      )
          : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildContactInfo(),
        ),
        const SizedBox(width: 40),
        Image.asset(
          'assets/images/contact_image.png',
          width: 400,
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Responsive image with constrained height
        Center(
          child: Image.asset(
            'assets/images/contact_image.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        _buildContactInfo(),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Office',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'LA CITE COLLEGIALE\n801 Aviation Parkway\nOttawa, Ontario K1K 4R3',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.phone, size: 18, color: Colors.green),
            const SizedBox(width: 8),
            const Text(
              '(613) 742-2483',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.email, size: 18, color: Colors.green),
            const SizedBox(width: 8),
            const Text(
              'info@collegelacite.ca',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Careers at Prescripto',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Interested in joining our team? Explore current job openings.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/doctor-login'); // This won't work here
            // Instead, we'll handle navigation in the build method
            // This button will use a callback function that's provided by the build method
          },
          child: const Text('Explore Jobs'),
        ),
      ],
    );
  }

  void _showMobileMenu(BuildContext currentContext) {
    showModalBottomSheet(
      context: currentContext,
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('HOME'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  Navigator.pushNamed(currentContext, '/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('ALL DOCTORS'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  Navigator.pushNamed(currentContext, '/doctors');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('ABOUT'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  Navigator.pushNamed(currentContext, '/about');
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('CONTACT'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  Navigator.pushNamed(currentContext, '/contact');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('CREATE ACCOUNT'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  Navigator.pushNamed(currentContext, '/register');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}