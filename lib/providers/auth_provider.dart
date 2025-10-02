// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../constants/app_constants.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String email, String password) async {
    // Input validation
    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        isLoading: false, 
        error: 'Please fill in all fields'
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Demo validation - in real app, this would be API call
      if (email == 'demo@shophy.com' && password == 'password') {
        final user = User(
          id: '1',
          email: email,
          firstName: 'Demo',
          lastName: 'User',
          avatar: 'assets/images/profile_placeholder.jpg',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        state = state.copyWith(user: user, isLoading: false);
      } else {
        throw Exception('Invalid email or password');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        error: e.toString().replaceFirst('Exception: ', '')
      );
    }
  }

  // UPDATED: Proper named parameters matching your User model
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    // Input validation
    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      state = state.copyWith(
        isLoading: false, 
        error: 'Please fill in all fields'
      );
      return;
    }

    if (password.length < AppConstants.minPasswordLength) {
      state = state.copyWith(
        isLoading: false,
        error: 'Password must be at least ${AppConstants.minPasswordLength} characters'
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Check if user already exists (demo logic)
      if (email == 'demo@shophy.com') {
        throw Exception('User with this email already exists');
      }
      
      // Create new user - matches your User model exactly
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        firstName: firstName, // Your model accepts nullable, but we have required params
        lastName: lastName,   // Your model accepts nullable, but we have required params
        avatar: 'assets/images/profile_placeholder.jpg',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        emailVerified: false, // Default for new registrations
      );
      
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        error: e.toString().replaceFirst('Exception: ', '')
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = AuthState();
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  // NEW: Update user profile - matches your User model
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? avatar,
  }) async {
    if (state.user == null) return;

    state = state.copyWith(isLoading: true);
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final updatedUser = state.user!.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        avatar: avatar,
        updatedAt: DateTime.now(),
      );

      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update profile: ${e.toString()}'
      );
    }
  }

  // NEW: Verify email
  Future<void> verifyEmail() async {
    if (state.user == null) return;

    state = state.copyWith(isLoading: true);
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final updatedUser = state.user!.copyWith(
        emailVerified: true,
        updatedAt: DateTime.now(),
      );

      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to verify email: ${e.toString()}'
      );
    }
  }

  // NEW: Check if user is logged in (for app startup)
  void checkAuthStatus() {
    // In a real app, you would check secure storage for tokens
    // For demo, we'll simulate checking stored credentials
    try {
      // Simulate checking stored auth data
      // If you implement local storage later, you can restore the user here
    } catch (e) {
      // No stored user, keep state as is
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final auth = AuthNotifier();
  // Check auth status when provider is initialized
  auth.checkAuthStatus();
  return auth;
});