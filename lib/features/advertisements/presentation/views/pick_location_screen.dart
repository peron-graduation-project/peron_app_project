import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class MapResult {
  final double latitude;
  final double longitude;
  final String address;
  const MapResult({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({Key? key}) : super(key: key);

  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  GoogleMapController? _controller;
  LatLng? _pickedLatLng;
  String _pickedAddress = 'الموقع المحدد';

  final loc.Location _location = loc.Location();

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndSetMarker();
  }

  Future<void> _getCurrentLocationAndSetMarker() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    final currentLocation = await _location.getLocation();

    final LatLng pos = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    _updateMarkerAndAddress(pos);

    _controller?.animateCamera(CameraUpdate.newLatLngZoom(pos, 16));
  }

  Future<void> _updateMarkerAndAddress(LatLng pos) async {
    String address = 'الموقع المحدد';
    try {
      final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        address =
            "${p.street ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}, ${p.country ?? ''}";
      }
    } catch (e) {
      print('خطأ في جلب العنوان: $e');
    }

    setState(() {
      _pickedLatLng = pos;
      _pickedAddress = address;
    });
  }

  void _onMapTap(LatLng pos) {
    _updateMarkerAndAddress(pos);
  }

  void _confirm() {
    if (_pickedLatLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تحديد الموقع')),
      );
      return;
    }

    Navigator.of(context).pop(MapResult(
      latitude: _pickedLatLng!.latitude,
      longitude: _pickedLatLng!.longitude,
      address: _pickedAddress,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final marker = _pickedLatLng != null
        ? Marker(
            markerId: const MarkerId('picked'),
            position: _pickedLatLng!,
            infoWindow: InfoWindow(title: _pickedAddress),
          )
        : null;

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, elevation: 0),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: const LatLng(31.037933, 31.381523), 
              zoom: 12,
            ),
            onMapCreated: (controller) => _controller = controller,
            onTap: _onMapTap,
            markers: marker != null ? {marker} : {},
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _confirm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('تأكيد الموقع'),
            ),
          ),
        ],
      ),
    );
  }
}
