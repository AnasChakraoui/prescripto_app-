import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminAppointmentsPage extends StatelessWidget {
  const AdminAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we're on a mobile-sized screen
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/images/logo.svg",
              width: isMobile ? 32 : 40,
              height: isMobile ? 32 : 40,
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
          if (!isMobile)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.blue),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/admin-login');
              },
            ),
        ],
      ),
      // drawer: isMobile
      //     ? Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue.shade50,
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             SvgPicture.asset(
      //               "assets/images/logo.svg",
      //               width: 48,
      //               height: 48,
      //             ),
      //             const SizedBox(height: 16),
      //             Text(
      //               'Admin Portal',
      //               style: Theme.of(context).textTheme.titleLarge?.copyWith(
      //                 color: Colors.blue,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       _buildNavItem(Icons.dashboard_outlined, 'Dashboard', context,
      //           '/admin-dashboard', false),
      //       _buildNavItem(Icons.calendar_today_outlined, 'Appointments',
      //           context, '/admin-appointments', true),
      //       _buildNavItem(Icons.person_add_outlined, 'Add Doctor', context,
      //           '/add-doctor', false),
      //       _buildNavItem(Icons.people_outline, 'Doctors List', context,
      //           '/doctors-list', false),
      //     ],
      //   ),
      // )
      //     : null,
      body: Row(
        children: [
          // Navigation Drawer for desktop/tablet
          if (!isMobile)
            Container(
              width: 220,
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
                      '/admin-dashboard', false),
                  _buildNavItem(Icons.calendar_today_outlined, 'Appointments',
                      context, '/admin-appointments', true),
                  _buildNavItem(Icons.person_add_outlined, 'Add Doctor', context,
                      '/add-doctor', false),
                  _buildNavItem(Icons.people_outline, 'Doctors List', context,
                      '/doctors-list', false),
                ],
              ),
            ),
          // Main Content
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Appointments',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    isMobile
                        ? _buildMobileAppointmentsList()
                        : _buildDesktopAppointmentsTable(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Bottom navigation for mobile
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/admin-dashboard');
              break;
            case 1:
            // Already on appointments page
              break;
            case 2:
              Navigator.pushNamed(context, '/doctors-list');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Doctors',
          ),
        ],
      )
          : null,
    );
  }

  Widget _buildMobileAppointmentsList() {
    final List<Map<String, dynamic>> appointments = [
      {
        'number': '1',
        'patient': 'ammar sohail',
        'age': 'Noah',
        'dateTime': '18 Apr 2025, 12:00',
        'doctor': 'Richard James',
        'fees': '\$50',
        'status': null,
      },
      {
        'number': '2',
        'patient': 'Redouane Noury',
        'age': '43',
        'dateTime': '19 Apr 2025, 01:00',
        'doctor': 'Dr. Ava Mikhail',
        'fees': '\$60',
        'status': 'Cancelled',
      },
      {
        'number': '3',
        'patient': 'Redouane Noury',
        'age': '43',
        'dateTime': '18 Apr 2025, 01:00',
        'doctor': 'Richard James',
        'fees': '\$50',
        'status': 'Completed',
      },
      {
        'number': '4',
        'patient': 'Redouane Noury',
        'age': '43',
        'dateTime': '17 Apr 2025, 10:00',
        'doctor': 'Dr. Christopher Davis',
        'fees': '\$50',
        'status': 'Completed',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person_outline,
                          size: 20, color: Colors.grey.shade400),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment['patient'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Age: ${appointment['age']}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (appointment['status'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: appointment['status'] == 'Completed'
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          appointment['status'],
                          style: TextStyle(
                            color: appointment['status'] == 'Completed'
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                    Text(
                      appointment['dateTime'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.attach_money,
                        size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                    Text(
                      appointment['fees'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.medical_services_outlined,
                          size: 14, color: Colors.blue.shade700),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appointment['doctor'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopAppointmentsTable() {
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const SizedBox(width: 50, child: Text('#')),
                const SizedBox(width: 200, child: Text('Patient')),
                const SizedBox(width: 80, child: Text('Age')),
                const SizedBox(width: 150, child: Text('Date & Time')),
                const SizedBox(width: 150, child: Text('Doctor')),
                const SizedBox(width: 80, child: Text('Fees')),
                const Expanded(child: Text('Action')),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildAppointmentRow(
            '1',
            'ammar sohail',
            'Noah',
            '18 Apr 2025, 12:00',
            'Richard James',
            '\$50',
            null,
          ),
          _buildAppointmentRow(
            '2',
            'Redouane Noury',
            '43',
            '19 Apr 2025, 01:00',
            'Dr. Ava Mikhail',
            '\$60',
            'Cancelled',
          ),
          _buildAppointmentRow(
            '3',
            'Redouane Noury',
            '43',
            '18 Apr 2025, 01:00',
            'Richard James',
            '\$50',
            'Completed',
          ),
          _buildAppointmentRow(
            '4',
            'Redouane Noury',
            '43',
            '17 Apr 2025, 10:00',
            'Dr. Christopher Davis',
            '\$50',
            'Completed',
          ),
        ],
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

  Widget _buildAppointmentRow(String number, String patient, String age,
      String dateTime, String doctor, String fees, String? status) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(number)),
          SizedBox(
            width: 200,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(patient)),
              ],
            ),
          ),
          SizedBox(width: 80, child: Text(age)),
          SizedBox(width: 150, child: Text(dateTime)),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(doctor)),
              ],
            ),
          ),
          SizedBox(width: 80, child: Text(fees)),
          Expanded(
            child: status != null
                ? Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == 'Completed'
                    ? Colors.green.shade50
                    : Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'Completed'
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : Container(),
          ),
        ],
      ),
    );
  }
}