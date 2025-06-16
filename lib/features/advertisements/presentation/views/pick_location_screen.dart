import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';

class MapResult {
  final double latitude;
  final double longitude;
  final String address;

  MapResult({
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
  final loc.Location _locationService = loc.Location();
  LatLng? _currentLatLng;
  bool _loading = true;

  final List<Marker> _markers = [];
  final List<Polyline> _polylines = [];
  StreamSubscription<loc.LocationData>? _locSub;

  @override
  void initState() {
    super.initState();
    _initLocation();
    if (!kIsWeb) {
      _locSub = _locationService.onLocationChanged.listen((d) {
        if (d.latitude != null && d.longitude != null) {
          _currentLatLng = LatLng(d.latitude!, d.longitude!);
          _refreshCurrentMarker();
        }
      });
    }
  }

  @override
  void dispose() {
    _locSub?.cancel();
    super.dispose();
  }

  Future<void> _initLocation() async {
    if (kIsWeb) {
      _currentLatLng = LatLng(31.0447, 31.3785);
      setState(() => _loading = false);
      return;
    }

    bool serviceEnabled = await _locationService.serviceEnabled() ||
        await _locationService.requestService();
    var permission = await _locationService.hasPermission();
    if (permission == loc.PermissionStatus.denied) {
      permission = await _locationService.requestPermission();
    }
    if (serviceEnabled && permission == loc.PermissionStatus.granted) {
      final data = await _locationService.getLocation();
      if (data.latitude != null && data.longitude != null) {
        _currentLatLng = LatLng(data.latitude!, data.longitude!);
        _refreshCurrentMarker();
      }
    }
    setState(() => _loading = false);
  }

  void _refreshCurrentMarker() {
    _markers.removeWhere((m) => m.key == const ValueKey('current'));
    if (_currentLatLng != null) {
      _markers.add(
        Marker(
          key: const ValueKey('current'),
          point: _currentLatLng!,
          width: 80,
          height: 80,
          child: const Icon(Icons.my_location, size: 48, color: Colors.blue),
        ),
      );
    }
    setState(() {});
  }

  Future<void> _onTap(LatLng pos) async {
    String name = 'الموقع المحدد';
    try {
      final places = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (places.isNotEmpty) name = places.first.name ?? name;
    } catch (_) {}

    _markers.removeWhere((m) => m.key != const ValueKey('current'));
    _markers.add(
      Marker(
        key: ValueKey(pos.toString()),
        point: pos,
        width: 80,
        height: 80,
        child: const Icon(Icons.location_on, size: 48, color: Colors.red),
      ),
    );

    _polylines
      ..clear()
      ..add(
        Polyline(
          points: [_currentLatLng!, pos],
          strokeWidth: 4,
        ),
      );

    Navigator.of(context).pop(
      MapResult(latitude: pos.latitude, longitude: pos.longitude, address: name),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
      ),
      body: _loading || _currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: _currentLatLng!,
                initialZoom: 15,
                onTap: (_, point) => _onTap(point),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                if (_markers.isNotEmpty) MarkerLayer(markers: _markers),
                if (_polylines.isNotEmpty) PolylineLayer(polylines: _polylines),
              ],
            ),
    );
  }
}
