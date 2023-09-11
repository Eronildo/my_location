import 'package:flutter/material.dart';
import 'core/injector/app_injector.dart';
import 'my_location_app.dart';

void main() {
  setupAppInjector();
  runApp(const MyLocationApp());
}
