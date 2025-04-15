import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentsPage extends StatefulWidget {
  const DoctorAppointmentsPage({super.key});

  @override
  State<DoctorAppointmentsPage> createState() => _DoctorAppointmentsPageState();
}

class _DoctorAppointmentsPageState extends State<DoctorAppointmentsPage> {
  List<Map<String, dynamic>> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      final appointments = await Supabase.instance.client
          .from('appointments')
          .select('''
            *,
            patients:users (
              full_name,
              email
            )
          ''')
          .eq('doctor_id', user.id)
          .order('appointment_date', ascending: true);

      setState(() {
        _appointments = List<Map<String, dynamic>>.from(appointments);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading appointments: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateAppointmentStatus(String appointmentId, String status) async {
    try {
      await Supabase.instance.client.from('appointments').update({
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', appointmentId);

      _loadAppointments(); // Reload appointments after update
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating appointment: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            Container(
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
          if (!isMobile)
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
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.blue),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/doctor-login');
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
      //               'Doctor Portal',
      //               style: Theme.of(context).textTheme.titleLarge?.copyWith(
      //                 color: Colors.blue,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       _buildNavItem(Icons.dashboard_outlined, 'Dashboard', context,
      //           '/doctor-dashboard', false),
      //       _buildNavItem(Icons.calendar_today_outlined, 'Appointments',
      //           context, '/doctor-appointments', true),
      //       _buildNavItem(Icons.person_outline, 'Profile', context,
      //           '/doctor-profile-edit', false),
      //     ],
      //   ),
      // )
      //     : null,
      body: Row(
        children: [
          // Navigation Drawer for desktop/tablet
          if (!isMobile)
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                children: [
                  _buildNavItem(Icons.dashboard_outlined, 'Dashboard', context,
                      '/doctor-dashboard', false),
                  _buildNavItem(Icons.calendar_today_outlined, 'Appointments',
                      context, '/doctor-appointments', true),
                  _buildNavItem(Icons.person_outline, 'Profile', context,
                      '/doctor-profile-edit', false),
                ],
              ),
            ),
          // Main Content
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Appointments',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        isMobile
                            ? IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: _loadAppointments,
                        )
                            : TextButton.icon(
                          onPressed: _loadAppointments,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Refresh'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (_appointments.isEmpty)
                      Center(
                        child: Text(
                          'No appointments found',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      )
                    else
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
              Navigator.pushNamed(context, '/doctor-dashboard');
              break;
            case 1:
            // Already on appointments page
              break;
            case 2:
              Navigator.pushNamed(context, '/doctor-profile-edit');
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
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      )
          : null,
    );
  }

  Widget _buildMobileAppointmentsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        final patient = appointment['patients'] as Map<String, dynamic>;
        final appointmentDate = DateTime.parse(appointment['appointment_date']);
        final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(appointmentDate);

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
                            patient['full_name'] ?? 'N/A',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Age: ${appointment['age']?.toString() ?? 'N/A'}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(appointment['status'])
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        appointment['status'] ?? 'Pending',
                        style: TextStyle(
                          color: _getStatusColor(appointment['status']),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Text(
                              formattedDate,
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
                              '\$${appointment['fee'] ?? 0}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                appointment['payment_method'] ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      onSelected: (String status) {
                        _updateAppointmentStatus(appointment['id'], status);
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'confirmed',
                          child: Text('Confirm'),
                        ),
                        const PopupMenuItem(
                          value: 'completed',
                          child: Text('Complete'),
                        ),
                        const PopupMenuItem(
                          value: 'cancelled',
                          child: Text('Cancel'),
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Update'),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade600,
                            ),
                          ],
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
                const SizedBox(width: 180, child: Text('Patient')),
                const SizedBox(width: 100, child: Text('Payment')),
                const SizedBox(width: 80, child: Text('Age')),
                const SizedBox(width: 150, child: Text('Date & Time')),
                const SizedBox(width: 80, child: Text('Fees')),
                const Expanded(child: Text('Status')),
                const SizedBox(width: 100, child: Text('Action')),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _appointments.length,
            itemBuilder: (context, index) {
              final appointment = _appointments[index];
              final patient = appointment['patients'] as Map<String, dynamic>;
              final appointmentDate = DateTime.parse(appointment['appointment_date']);
              final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(appointmentDate);

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text('${index + 1}')),
                    SizedBox(
                      width: 180,
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person_outline,
                                size: 16, color: Colors.grey.shade400),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              patient['full_name'] ?? 'N/A',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          appointment['payment_method'] ?? 'N/A',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(appointment['age']?.toString() ?? 'N/A'),
                    ),
                    SizedBox(width: 150, child: Text(formattedDate)),
                    SizedBox(
                      width: 80,
                      child: Text('\$${appointment['fee'] ?? 0}'),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color:
                          _getStatusColor(appointment['status']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          appointment['status'] ?? 'Pending',
                          style: TextStyle(
                            color: _getStatusColor(appointment['status']),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: PopupMenuButton<String>(
                        onSelected: (String status) {
                          _updateAppointmentStatus(appointment['id'], status);
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'confirmed',
                            child: Text('Confirm'),
                          ),
                          const PopupMenuItem(
                            value: 'completed',
                            child: Text('Complete'),
                          ),
                          const PopupMenuItem(
                            value: 'cancelled',
                            child: Text('Cancel'),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Update'),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
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