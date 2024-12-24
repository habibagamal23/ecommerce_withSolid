import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class ILocationService {
  Future<Position> getCurrentPosition();
  Future<String> getAddressFromCoordinates(latitude , longitude);
}

class LocationService implements ILocationService {
  @override
  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception("Location permission denied.");
    }

    return await Geolocator.getCurrentPosition(
        locationSettings:  LocationSettings(
          accuracy: LocationAccuracy.high,)
    );
  }

  @override
  Future<String> getAddressFromCoordinates( latitude , longitude) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks.first;
    return "${place.street}, ${place.subLocality}, ${place.country}";
  }
}
