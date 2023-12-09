import 'package:flutter/material.dart';

enum UnitType {
  metric,
  standard,
}

class UnitsNotifier extends ChangeNotifier {
  UnitType _units = UnitType.metric; // Using the enum

  UnitsNotifier._privateConstructor();

  static final UnitsNotifier _instance = UnitsNotifier._privateConstructor();

  static UnitsNotifier get instance => _instance;

  String get units => _units == UnitType.metric ? "metric" : "standart";
  UnitType get uintsEnum => _units;

  // Function to toggle between unit types
  void toggleUnits() {
    if (_units == UnitType.metric) {
      _units = UnitType.standard;
    } else {
      _units = UnitType.metric;
    }
    notifyListeners(); // Notify listeners about the change.
  }
}
