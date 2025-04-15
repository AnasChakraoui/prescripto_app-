import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      // Bottom navigation for mobile
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.black,
      //   currentIndex: 2, // About page is selected
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
              const Text(
                'About Us',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Prescripto is your trusted partner for conveniently and efficiently managing your healthcare needs. Our platform aims to improve your experience by integrating advanced technologies, making it easier and faster to access care.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/about_image.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Why Choose Us',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Mobile-friendly list view instead of grid for feature cards
              const Column(
                children: [
                  FeatureCard(
                    icon: Icons.speed,
                    title: 'Efficiency',
                    description: 'Seamless and quick appointment scheduling that fits into your busy schedule.',
                  ),
                  SizedBox(height: 12),
                  FeatureCard(
                    icon: Icons.accessibility,
                    title: 'Convenience',
                    description: 'Access to a network of trusted healthcare professionals in your area.',
                  ),
                  SizedBox(height: 12),
                  FeatureCard(
                    icon: Icons.person,
                    title: 'Personalization',
                    description: 'Personalized recommendations and reminders to help you optimally manage your health.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.green),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}