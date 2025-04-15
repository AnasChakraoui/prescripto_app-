import 'package:flutter/material.dart';
import 'package:prescripto/pages/home_page_user.dart';
import 'package:prescripto/pages/user/appoinments/appointments_page.dart';
import 'package:prescripto/pages/user/auth/login_page.dart';
import 'package:prescripto/pages/user/auth/register_page.dart';
import 'package:prescripto/pages/user/home_page.dart';
import 'package:prescripto/pages/user/doctors/doctor_list_page.dart';
import 'package:prescripto/pages/user/doctors/doctor_profile_page.dart';
import 'package:prescripto/pages/user/about_page.dart';
import 'package:prescripto/pages/user/contact_page.dart';
import 'package:prescripto/pages/doctor/doctor_login_page.dart';
import 'package:prescripto/pages/doctor/doctor_dashboard_page.dart';
import 'package:prescripto/pages/doctor/doctor_appointments_page.dart';
import 'package:prescripto/pages/doctor/doctor_profile_page.dart';
import 'package:prescripto/pages/admin/admin_login_page.dart';
import 'package:prescripto/pages/admin/admin_dashboard_page.dart';
import 'package:prescripto/pages/admin/admin_appointments_page.dart';
import 'package:prescripto/pages/admin/add_doctor_page.dart';
import 'package:prescripto/pages/admin/doctors_list_page.dart';
import 'package:prescripto/pages/user/user_profile_page.dart';
import 'package:prescripto/screens/doctors_list_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/appointment_provider.dart';
import 'config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://wawieijufrfhxgdncquy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indhd2llaWp1ZnJmaHhnZG5jcXV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3NzEzODUsImV4cCI6MjA1OTM0NzM4NX0.4QRdfagZ8M2mTnfTChVs5ddvRcjcRI5McgXNXXUX5DA',
    debug: true, // Set to true to see detailed logs
  );
  
  runApp(const MyApp());
}
// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppointmentProvider(),
      child: MaterialApp(
        title: 'Prescripto',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/doctors': (context) =>  DoctorListPage(),
          '/doctor-profile': (context) => const DoctorProfilePage(),
          '/user-profile': (context) => const UserProfilePage(),
          '/appointments': (context) => const AppointmentsPage(),
          '/about': (context) => const AboutPage(),
          '/contact': (context) => const ContactPage(),
          '/doctor-login': (context) => const DoctorLoginPage(),
          '/doctor-dashboard': (context) => const DoctorDashboardPage(),
          '/doctor-appointments': (context) => const DoctorAppointmentsPage(),
          '/doctor-profile-edit': (context) => const DoctorProfileEditPage(),
          '/admin-login': (context) => const AdminLoginPage(),
          '/admin-dashboard': (context) => const AdminDashboardPage(),
          '/admin-appointments': (context) => const AdminAppointmentsPage(),
          '/add-doctor': (context) => const AddDoctorPage(),
          '/doctors-list': (context) => const DoctorsListPage(),
          '/userhome': (context) => const HomePageUser(),
        },
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          // Handle unknown routes
          return MaterialPageRoute(
            builder: (context) => const LoginPage(),
          );
        },
      ),
    );
  }
}