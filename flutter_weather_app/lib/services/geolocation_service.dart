import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
  return true;
}

Future<Position?> getCurrentPosition() async {
  final hasPermission = await handleLocationPermission();
  if (!hasPermission) {
    return null;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.toString());
    return position;
  } catch (e) {
    debugPrint(e.toString());

    return null;
  }
}