import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';

class LocationHelper {
  static Future<String?> getAndSaveLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check location service enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return 'Location service disabled';

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permission denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return 'Location permission permanently denied';
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Reverse geocode to get address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String address =
          '${place.locality}, ${place.administrativeArea}, ${place.country}';

      // Save to Hive
      var box = Hive.box('locationDB');
      await box.put('location', {
        // 'latitude': position.latitude,
        // 'longitude': position.longitude,
        'address': address,
      });

      return address; // Success
    } else {
      return 'No address found';
    }
  }

  static String? getSavedLocation() {
    var box = Hive.box('locationDB'); 
    return box.get('location')?['address'];
    
  }
}
