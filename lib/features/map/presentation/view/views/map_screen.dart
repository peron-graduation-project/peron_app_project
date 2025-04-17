import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/map/presentation/manager/get_nearest_cubit.dart';
import 'package:peron_project/features/map/presentation/manager/get_nearest_state.dart';

import '../widgets/map_search.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  loc.LocationData? _currentLocation;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final loc.Location _location = loc.Location();
  bool _isLoading = true;
  Marker? _currentLocationMarker;
  Marker? _userSelectedMarker;
  String _locationDetails = '';
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        setState(() => _isLoading = false);
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        print('Location permission denied.');
        setState(() => _isLoading = false);
        return;
      }
    }

    setState(() => _isLoading = true); // Set loading to true before getting location
    try {
      _currentLocation = await _location.getLocation(); // استخدام getLocation() بدلاً من getCurrentLocation()
      if (_currentLocation != null) {
        _currentLatLng = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
        _currentLocationMarker = Marker(
          markerId: const MarkerId("current_location"),
          position: _currentLatLng!,
          infoWindow: const InfoWindow(title: "موقعك الحالي"),
        );
        _markers.add(_currentLocationMarker!);
        context.read<GetNearestCubit>().getNearest(lat: _currentLatLng!.latitude!, lon: _currentLatLng!.longitude!);
      }
    } catch (e) {
      print('Error getting current location: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<double?> _calculateDistance(LatLng target) async {
    if (_currentLocation == null) return null;
    return geo.Geolocator.distanceBetween(
      _currentLocation!.latitude!,
      _currentLocation!.longitude!,
      target.latitude,
      target.longitude,
    );
  }

  void _updatePolylinesToProperties(List<LatLng> propertyLocations) {
    if (_currentLocation != null) {
      setState(() {
        _polylines.clear();
        for (int i = 0; i < propertyLocations.length; i++) {
          _polylines.add(Polyline(
            polylineId: PolylineId('route_to_property_$i'),
            color: Colors.green,
            width: 3,
            points: [
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
              propertyLocations[i],
            ],
          ));
        }
      });
    }
  }

  void _onMapTapped(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String locationName = placemarks.isNotEmpty ? placemarks.first.name ?? "الموقع المحدد" : "الموقع المحدد";

    setState(() {
      if (_userSelectedMarker != null) _markers.remove(_userSelectedMarker);

      _userSelectedMarker = Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: locationName),
      );
      _markers.add(_userSelectedMarker!);

      _locationDetails = locationName;

      context.read<GetNearestCubit>().getNearest(lat: position.latitude, lon: position.longitude);
    });
  }

  void _onMapSearchSubmitted(String locationQuery) async {
    List<Location> locations = await locationFromAddress(locationQuery);

    if (locations.isNotEmpty) {
      LatLng position = LatLng(locations.first.latitude, locations.first.longitude);
      _onMapTapped(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetNearestCubit, GetNearestState>(
      listener: (context, state) async {
        print('Listener triggered with state: $state'); // Debugging
        if (state is GetNearestStateSuccess) {
          print('GetNearestStateSuccess - Properties count: ${state.properties.length}'); // Debugging
          _markers.removeWhere((marker) => marker.markerId.value.startsWith('property_'));
          List<LatLng> propertyLocations = [];
          for (var property in state.properties) {
            print('Property Latitude: ${property.latitude}, Longitude: ${property.longitude}'); // Debugging
            if (property.latitude != null && property.longitude != null) {
              final distance = await _calculateDistance(LatLng(property.latitude, property.longitude));
              final distanceFormatted = distance != null ? '${distance.toStringAsFixed(2)} متر' : 'غير معروف';
              final propertyLatLng = LatLng(property.latitude, property.longitude);
              _markers.add(
                Marker(
                  markerId: MarkerId('property_${property.propertyId}'),
                  position: propertyLatLng,
                  infoWindow: InfoWindow(
                    title: property.title,
                    snippet: '${property.location} ($distanceFormatted)',
                  ),
                ),
              );
              propertyLocations.add(propertyLatLng);
            } else {
              print('Skipping property due to null latitude or longitude'); // Debugging
            }
          }
          _updatePolylinesToProperties(propertyLocations);
          setState(() {});
          print('_markers count after setState: ${_markers.length}'); // Debugging
        } else if (state is GetNearestStateFailure) {
          print('GetNearestStateFailure: ${state.errorMessage}'); // Debugging
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطأ في تحميل الشقق القريبة: ${state.errorMessage}')),
          );
        } else if (state is GetNearestStateStateLoading) {
          print('GetNearestStateStateLoading'); // Debugging
        }
      },
      builder: (context, state) {
        return _buildMapScreen(context, state);
      },
    );
  }

  Widget _buildMapScreen(BuildContext context, GetNearestState state) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CustomArrowBack(),
            Expanded(child: MapSearch(onSubmitted: _onMapSearchSubmitted)),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      )
          : Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: _currentLatLng ?? const LatLng(30.0444, 31.2357), zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              markers: _markers.toSet(),
              polylines: _polylines,
              onTap: _onMapTapped,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          if (state is GetNearestStateStateLoading)
            const LinearProgressIndicator(),
          Text('Number of markers: ${_markers.length}'), // Debugging
        ],
      ),
    );
  }
}