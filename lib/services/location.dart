import 'dart:async';
import 'package:flutter_hello_world/models/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  late Position _currentLocation;
  late UserLocationModel _userLocationModel;
  final StreamController<UserLocationModel> _locationController =
      StreamController<UserLocationModel>();
  StreamSubscription<Position>? _positionStream;

  LocationService() {
    _positionStream = Geolocator.getPositionStream().listen((event) {
      _locationController
          .add(UserLocationModel(event.latitude, event.longitude));
    });
  }

  Future<UserLocationModel> getCurrentLocation() async {
    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isServiceEnabled) {
        isServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isServiceEnabled) {
          throw Exception("The Location service is disabled!");
        }
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location Permission requests has been denied!");
      }

      if (isServiceEnabled &&
          (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse)) {
        _currentLocation = await Geolocator.getCurrentPosition().timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            throw TimeoutException(
                "Location information could not be obtained within the requested time.");
          },
        );

        _userLocationModel = UserLocationModel(
            _currentLocation.latitude, _currentLocation.longitude);
        return _userLocationModel;
      } else {
        throw Exception("Location Service requests has been denied!");
      }
    } on TimeoutException catch (_) {
      print(_);
      throw _;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void closeLocation() {
    if (_positionStream != null) {
      _positionStream?.cancel();
      _locationController.close();
      _positionStream = null;
    } else {}
  }
}
