import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-wide theme state.
///
/// Lives above MaterialApp as a ValueNotifier so a toggle anywhere rebuilds
/// the whole tree, and the choice survives a reload.
class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.light);

  static const String _storageKey = 'theme_mode';

  SharedPreferences? _prefs;

  Future<void> load() async {
    try {
      _prefs = await SharedPreferences.getInstance();

      value = switch (_prefs?.getString(_storageKey)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.light,
      };
    } catch (_) {
      // Storage unavailable (private browsing, blocked site data) — the app
      // still works, it just won't remember the choice.
      value = ThemeMode.light;
    }
  }
  bool get isDark => value == ThemeMode.dark;

  Future<void> toggle() => setMode(isDark ? ThemeMode.light : ThemeMode.dark);

  Future<void> setMode(ThemeMode mode) async {
    if (mode == value) return;

    value = mode;

    try {
      await _prefs?.setString(
        _storageKey,
        mode == ThemeMode.dark ? 'dark' : 'light',
      );
    } catch (_) {
      // Non-fatal.
    }
  }
}

/// Single instance, readable from anywhere without plumbing.
final ThemeController themeController = ThemeController();
