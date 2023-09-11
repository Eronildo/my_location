import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const locationPermissionDenied = 0;
const locationPermissionDeniedForever = 1;
const locationPermissionWhileInUse = 2;

void mockGeolocatorPlugin({
  int checkPermissionResult = locationPermissionWhileInUse,
  int requestPermissionResult = locationPermissionWhileInUse,
}) {
  const channel = MethodChannel('flutter.baseflow.com/geolocator');

  Future<dynamic>? handler(MethodCall methodCall) async {
    if (methodCall.method == 'isLocationServiceEnabled') {
      return true;
    } else if (methodCall.method == 'checkPermission') {
      return checkPermissionResult;
    } else if (methodCall.method == 'requestPermission') {
      return requestPermissionResult;
    } else if (methodCall.method == 'getCurrentPosition') {
      return {
        'latitude': 1.0,
        'longitude': 1.0,
      };
    }

    return null;
  }

  TestWidgetsFlutterBinding.ensureInitialized();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);
}
