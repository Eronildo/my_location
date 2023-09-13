import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/injector/app_injector.dart';
import 'my_location_app.dart';

void main() async {
  await _initApp();
  runApp(const MyLocationApp());
}

/// Initialize the app.
Future<void> _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  setupAppInjector(sharedPreferences);
}
