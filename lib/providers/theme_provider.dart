// lib/providers/theme_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppTheme { light, dark }

class ThemeState {
  final AppTheme theme;

  ThemeState({this.theme = AppTheme.light});

  ThemeState copyWith({AppTheme? theme}) {
    return ThemeState(theme: theme ?? this.theme);
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState());

  void toggleTheme() {
    state = state.copyWith(
      theme: state.theme == AppTheme.light ? AppTheme.dark : AppTheme.light,
    );
  }

  void setTheme(AppTheme theme) {
    state = state.copyWith(theme: theme);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});