import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AppointmentScreen extends StatefulWidget {
  final List<Appointment> appointments;

  const AppointmentScreen({
    Key? key,
    required this.appointments,
  }) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: widget.appointments.isEmpty
          ? Center(
              child: Text(
                'No appointments booked yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: widget.appointments.length,
              itemBuilder: (context, index) {
                final appointment = widget.appointments[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Doctor: ${appointment.doctorName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Specialty: ${appointment.specialty}'),
                        Text('Date: ${_formatDate(appointment.dateTime)}'),
                        Text('Time: ${_formatTime(appointment.dateTime)}'),
                        SizedBox(height: 8),
                        Text('Patient: ${appointment.patientName}'),
                        Text('Reason: ${appointment.reason}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
} 