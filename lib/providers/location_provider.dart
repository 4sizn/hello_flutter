import 'package:flutter/foundation.dart';
import 'package:flutter_hello_world/models/location.dart';
import 'package:flutter_hello_world/services/location.dart';

enum LocationProviderStatus {
  initial,
  loading,
  success,
  error,
}

class LocationProvider with ChangeNotifier {
  late UserLocationModel _userLocation;
  LocationService _locationService = LocationService();

  LocationProviderStatus _status = LocationProviderStatus.initial;

  Future<void> getLocation() async {
    try {
      _updateStatus(LocationProviderStatus.loading);
      _userLocation = await _locationService.getCurrentLocation();
      print(_userLocation);

      _updateStatus(LocationProviderStatus.success);
    } catch (e) {
      _updateStatus(LocationProviderStatus.error);
    }
  }

  void _updateStatus(LocationProviderStatus status) {
    if (_status != status) {
      _status = status;
      notifyListeners();
    }
  }
}
