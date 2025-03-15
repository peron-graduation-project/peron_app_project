import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/map/widgets/map_search.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
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

      await _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
            zoom: 18,
          ),
        ),
      );

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

    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 18,
        ),
      ),
    );
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        LatLng location = LatLng(locations.first.latitude, locations.first.longitude);
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: 18),
          ),
        );

        setState(() {
          _userSelectedMarker = Marker(
            markerId: MarkerId(query),
            position: location,
            infoWindow: InfoWindow(title: query),
          );
          _markers.add(_userSelectedMarker!);
          _locationDetails = 'Location: $query\nLat: ${location.latitude}\nLng: ${location.longitude}';
        });
      }
    } catch (e) {}
  }

  void _onMapTapped(LatLng position) async {
    setState(() {
      if (_userSelectedMarker != null) _markers.remove(_userSelectedMarker);

      _userSelectedMarker = Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: "Selected Location"),
      );
      _markers.add(_userSelectedMarker!);
      _locationDetails = 'Lat: ${position.latitude}\nLng: ${position.longitude}';
    });

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      setState(() {
        _locationDetails = 'Location: ${placemarks.first.name}\nLat: ${position.latitude}\nLng: ${position.longitude}';
      });
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
              SizedBox(width: screenWidth * 0.02),
              Expanded(child: MapSearch(onSubmitted: _searchLocation)),
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
          children: [
            CustomArrowBack(),
            SizedBox(width: screenWidth * 0.02),
            Expanded(child: MapSearch(onSubmitted: _searchLocation)),
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
          Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.015,
              horizontal: screenWidth * 0.05,
            ),
            color: Colors.grey[200],
            child: Text(
              _locationDetails.isNotEmpty
                  ? _locationDetails
                  : 'اضغط علي الخريطه لإختيار مكان ',
              style: theme.bodyMedium?.copyWith(color: Color(0xff282929), fontSize: screenWidth * 0.04),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
