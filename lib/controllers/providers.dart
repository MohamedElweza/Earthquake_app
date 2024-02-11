import 'package:flutter/material.dart';

class MagnitudeTypesDropdownState with ChangeNotifier {
  String _selectedOption = 'mwc';

  String get selectedOption => _selectedOption;

  set selectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
  }
}

class MagnitudeSourcesDropdownState with ChangeNotifier {
  String _selectedOption = 'us';

  String get selectedOption => _selectedOption;

  set selectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
  }
}

class LocationProvider extends ChangeNotifier {
  String _selectedLocation = 'Pick Location';

  String get selectedLocation => _selectedLocation;

  set selectedLocation(String value) {
    _selectedLocation = value;
    notifyListeners();
  }
}