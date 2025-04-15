import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';
import '../screens/appointment_screen.dart';
import '../widgets/booking_form_dialog.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String image;
  final String experience;
  final double rating;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.image,
    this.experience = '',
    this.rating = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(image),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        specialty,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text(' $rating'),
                  ],
                ),
                Text(experience),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final appointment = await showDialog<Appointment>(
                    context: context,
                    builder: (context) => BookingFormDialog(
                      doctorName: name,
                      specialty: specialty, selectedDate: '', selectedTime: '',
                    ),
                  );

                  if (appointment != null) {
                    // Add the appointment to your list/storage
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Appointment booked successfully!')),
                    );
                  }
                },
                child: Text('ok Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}