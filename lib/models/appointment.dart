class Appointment {
  final String doctorName;
  final String specialty;
  final String patientName;
  final String email;
  final String phone;
  final String reason;
  final DateTime dateTime;

  Appointment({
    required this.doctorName,
    required this.specialty,
    required this.patientName,
    required this.email,
    required this.phone,
    required this.reason,
    required this.dateTime,
  });
} 