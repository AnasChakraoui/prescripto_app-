import 'package:flutter/material.dart';
import '../widgets/booking_form_dialog.dart';
import '../models/appointment.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_provider.dart';

class DoctorProfilePage extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String imageUrl;
  final double appointmentFee;
  final String about;

  const DoctorProfilePage({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.imageUrl,
    required this.appointmentFee,
    required this.about,
  }) : super(key: key);

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  String? selectedDate;
  String? selectedTime;
  
  // List of all available doctors
  final List<Map<String, dynamic>> doctorsData = [
    {
      'name': 'Richard James',
      'specialty': 'General Physician',
      'status': 'Available',
      'image': 'assets/images/doc1.png',
      'about': 'Dr. James is a highly qualified General Physician with extensive experience in treating patients.',
      'appointmentFee': 50.0,
    },
    {
      'name': 'Dr. Christopher Davis',
      'specialty': 'General Physician',
      'status': 'Available',
      'image': 'assets/images/doc2.png',
      'about': 'Dr. Davis is a dedicated General Physician known for his patient-centered approach.',
      'appointmentFee': 50.0,
    },
    {
      'name': 'Dr. Chloe Evans',
      'specialty': 'General Physician',
      'status': 'Available',
      'image': 'assets/images/doc3.png',
      'about': 'Dr. Evans is an experienced General Physician specializing in preventive care.',
      'appointmentFee': 45.0,
    },
    {
      'name': 'Dr. Emily Larson',
      'specialty': 'Dermatologist',
      'status': 'Available',
      'image': 'assets/images/doc4.png',
      'about': 'Dr. Larson is a board-certified Dermatologist with expertise in skin conditions.',
      'appointmentFee': 60.0,
    },
    // Add more doctors here...
    {
      'name': 'Dr. Timothy White',
      'specialty': 'Neurologist',
      'status': 'Available',
      'image': 'assets/images/doc5.png',
      'about': 'Dr. White is a renowned Neurologist with extensive experience in treating neurological disorders.',
      'appointmentFee': 70.0,
    },
    {
      'name': 'Dr. Ryan Martinez',
      'specialty': 'Gastroenterologist',
      'status': 'Available',
      'image': 'assets/images/doc6.png',
      'about': 'Dr. Martinez is a skilled Gastroenterologist specializing in digestive health.',
      'appointmentFee': 65.0,
    },
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Dermatologist',
      'status': 'Available',
      'image': 'assets/images/doc7.png',
      'about': 'Dr. Johnson is a skilled Dermatologist with expertise in cosmetic procedures.',
      'appointmentFee': 55.0,
    },
    {
      'name': 'Dr. Michael Brown',
      'specialty': 'General Physician',
      'status': 'Available',
      'image': 'assets/images/doc8.png',
      'about': 'Dr. Brown is a compassionate General Physician focused on family medicine.',
      'appointmentFee': 45.0,
    },
    // Add more doctors as needed...
  ];

  List<Map<String, String>> _buildDateSlots() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.add(Duration(days: index));
      return {
        'day': _getDayName(date.weekday),
        'date': date.day.toString(),
        'full': '${date.year}-${date.month}-${date.day}',
      };
    });
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'MON';
      case 2: return 'TUE';
      case 3: return 'WED';
      case 4: return 'THU';
      case 5: return 'FRI';
      case 6: return 'SAT';
      case 7: return 'SUN';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Image - Updated styling
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Color(0xFF4B6BFF), // Blue background color as in image
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Doctor Details - Updated styling
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.doctorName,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Icon(Icons.verified, color: Color(0xFF4B6BFF), size: 20),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.specialty,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Appointment fee \$${widget.appointmentFee.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // About Section - Updated styling
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.about,
                    style: TextStyle(
                      color: Colors.grey[600],
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Updated Booking Slots Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking slots',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Date Selection
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildDateSlots().map((date) {
                        bool isSelected = date['full'] == selectedDate;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date['full'];
                              selectedTime = null; // Reset time when date changes
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Color(0xFF4B6BFF) : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  date['day']!,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  date['date']!,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Time Slots
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _buildTimeSlots(),
                  ),
                ],
              ),
            ),

            // Updated Book Appointment Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: selectedDate == null || selectedTime == null ? null : () async {
                    final appointment = await showDialog<Appointment>(
                      context: context,
                      builder: (context) => BookingFormDialog(
                        doctorName: widget.doctorName,
                        specialty: widget.specialty,
                        selectedDate: selectedDate!,
                        selectedTime: selectedTime!,
                      ),
                    );

                    if (appointment != null) {
                      Provider.of<AppointmentProvider>(context, listen: false)
                          .addAppointment(appointment);
                          
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Success'),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Appointment booked successfully!'),
                              SizedBox(height: 8),
                              Text('Doctor: ${widget.doctorName}'),
                              Text('Date: $selectedDate'),
                              Text('Time: $selectedTime'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/appointments');
                              },
                              child: Text('View My Appointments'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4B6BFF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Book an appointment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Related Doctors Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Related Doctors',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Simply browse through our extensive list of trusted doctors.',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildRelatedDoctors(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTimeSlots() {
    final times = [
      '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
      '14:00', '14:30', '15:00', '15:30', '16:00', '16:30',
      '17:00', '17:30',
    ];

    return times.map((time) {
      bool isSelected = time == selectedTime;
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedTime = time;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF4B6BFF) : Colors.white,
            border: Border.all(color: isSelected ? Color(0xFF4B6BFF) : Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildRelatedDoctors(BuildContext context) {
    // Filter doctors with the same specialty, excluding the current doctor
    final relatedDoctors = doctorsData.where((doctor) =>
      doctor['specialty'] == widget.specialty && doctor['name'] != widget.doctorName
    ).toList();

    if (relatedDoctors.isEmpty) {
      return [
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            'No related doctors found',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
      ];
    }

    return relatedDoctors.map((doctor) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorProfilePage(
                doctorName: doctor['name'],
                specialty: doctor['specialty'],
                imageUrl: doctor['image'],
                appointmentFee: doctor['appointmentFee'],
                about: doctor['about'],
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(right: 16),
          width: 120,
          child: Column(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(doctor['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                doctor['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                doctor['specialty'],
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}