import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<String?> getUserCity() async {
  try {
    // Check location service status and permissions
    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      // Handle disabled location service
      return 'Location service disabled';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle denied permission
        return 'Location permission denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied permission
      return 'Location permission permanently denied';
    }

    // Retrieve current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Reverse geocoding to get the city
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      String city = placemarks.first.locality ?? '';
      return city;
    } else {
      return 'Unknown city';
    }
  } catch (e) {
    print('Error: $e');
    return 'Error occurred';
  }
}
