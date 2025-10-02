// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

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
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      // For demo, create a mock user
      final user = User(
        id: '1',
        email: email,
        firstName: 'Demo',
        lastName: 'User',
        avatar: 'assets/images/profile_placeholder.jpg',
      );
      
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Login failed: $e');
    }
  }

  Future<void> register(String email, String password, String firstName, String lastName) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      // For demo, create a mock user
      final user = User(
        id: '1',
        email: email,
        firstName: firstName,
        lastName: lastName,
        avatar: 'assets/images/profile_placeholder.jpg',
      );
      
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Registration failed: $e');
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(milliseconds: 500));
    state = AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});