import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
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

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation();
      if (_currentLocation == null) return;

      setState(() {
        _currentLocationMarker = Marker(
          markerId: MarkerId("current_location"),
          position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          infoWindow: InfoWindow(title: "Your Location"),
        );
        _markers.add(_currentLocationMarker!);
        _isLoading = false;
      });

      _location.onLocationChanged.listen((loc.LocationData currentLocation) {
        if (_currentLocation != null &&
            (currentLocation.latitude != _currentLocation!.latitude ||
                currentLocation.longitude != _currentLocation!.longitude)) {
          _updateMarkerAndCamera(currentLocation);
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateMarkerAndCamera(loc.LocationData currentLocation) {
    setState(() {
      _currentLocation = currentLocation;
      _currentLocationMarker = Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        infoWindow: InfoWindow(title: "Your Location"),
      );
      _markers.add(_currentLocationMarker!);
    });

    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 18,
        ),
      ),
    );
  }

  void _updatePolyline(LatLng position) {
    if (_currentLocation != null && _userSelectedMarker != null) {
      setState(() {
        _polylines.clear();
        _polylines.add(Polyline(
          polylineId: PolylineId("route"),
          color: Colors.blue,
          width: 5,
          points: [
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
            position,
          ],
        ));
      });
    }
  }

  void _onMapTapped(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String locationName = placemarks.isNotEmpty ? placemarks.first.name ?? "Selected Location" : "Selected Location";

    setState(() {
      if (_userSelectedMarker != null) _markers.remove(_userSelectedMarker);

      _userSelectedMarker = Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: locationName),
      );
      _markers.add(_userSelectedMarker!);

      _locationDetails = locationName;

      _updatePolyline(position);
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
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CustomArrowBack(),
              Expanded(child: MapSearch(onSubmitted: _onMapSearchSubmitted)),
            ],
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomArrowBack(),
            Expanded(child: MapSearch(onSubmitted: _onMapSearchSubmitted)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(0, 0), zoom: 2),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                _getCurrentLocation();
              },
              markers: _markers,
              polylines: _polylines,
              onTap: _onMapTapped,
            ),
          ),
        ],
      ),
    );
  }
}
