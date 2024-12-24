import 'package:fibeecomm/features/payment/Adressnew/renew.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final ILocationService _locationService = LocationService();

  LatLng _selectedLocation = const LatLng(10.762622, 106.660172);
  String _address = "Fetching location...";
  late GoogleMapController _mapController;

  Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId("initial"),
      position: const LatLng(10.762622, 106.660172),
    ),
  };

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
  }

  Future<void> _initCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      final address = await
      _locationService.getAddressFromCoordinates(position.latitude, position.longitude);
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _address = address;
        _markers = {
          Marker(
            markerId: const MarkerId("current"),
            position: _selectedLocation,
          ),
        };
      });
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          _selectedLocation,
          14,
        ),
      );
    } catch (e) {
      setState(() {
        _address = "Failed to fetch location: $e";
      });
    }
  }

  Future<void> _onMapTap(LatLng position) async {
    try {
      final address = await _locationService.getAddressFromCoordinates(position.latitude , position.longitude);
      setState(() {
        _selectedLocation = position;
        _address = address;
        _markers = {
          Marker(
            markerId: const MarkerId("selected"),
            position: _selectedLocation,
          ),
        };
      });
    } catch (e) {
      setState(() {
        _address = "Failed to get address.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Location"), centerTitle: true),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 18,
            ),
            markers: _markers,
            onTap: _onMapTap,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  child: Text(
                    _address,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _address);
                  },
                  child: const Text("Confirm Location"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
