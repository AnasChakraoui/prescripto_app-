import 'package:supabase_flutter/supabase_flutter.dart';

// Replace with your Supabase URL and anon key
const String supabaseUrl = 'https://wawieijufrfhxgdncquy.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indhd2llaWp1ZnJmaHhnZG5jcXV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3NzEzODUsImV4cCI6MjA1OTM0NzM4NX0.4QRdfagZ8M2mTnfTChVs5ddvRcjcRI5McgXNXXUX5DA';

// Initialize Supabase singleton
final supabase = Supabase.instance.client; 