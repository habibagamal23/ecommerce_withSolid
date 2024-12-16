import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

abstract class IAddressRepository {
  Future<String> getCurrentAddress();
}

class AddressRepository implements IAddressRepository {
  @override
  Future<String> getCurrentAddress() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied.");
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      return "${place.street}, ${place.subLocality}, ${place.country}";
    } catch (e) {
      throw Exception("Failed to fetch address: $e");
    }
  }
}
