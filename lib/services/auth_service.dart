import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign Up
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String userType,
  }) async {
    try {
      // First, create the auth user
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
          'user_type': userType,
        },
      );

      if (response.user != null) {
        // Create the profile in the profiles table
        await _supabase.from('profiles').upsert({
          'id': response.user!.id,
          'email': email,
          'full_name': fullName,
          'phone': phone,
          'user_type': userType,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }

      return response;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  // Sign In
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  // Password Reset
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  // Get Current User
  User? get currentUser => _supabase.auth.currentUser;

  // Get User Profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  // Update User Profile
  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      if (currentUser == null) throw Exception('No user logged in');
      
      await _supabase
          .from('profiles')
          .update(data)
          .eq('id', currentUser!.id);
    } on PostgrestException catch (e) {
      throw Exception('Failed to update profile: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }

  // Check if user is logged in
  bool get isAuthenticated => currentUser != null;

  // Get user type (patient or doctor)
  Future<String?> getUserType() async {
    try {
      final profile = await getUserProfile(currentUser!.id);
      return profile?['user_type'] as String?;
    } catch (e) {
      return null;
    }
  }
} 