import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';

// كلاس الخريطة المصغر للاستخدام في صفحة تفاصيل العقار
class LocationMapWidget extends StatefulWidget {
  final Property property;
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;
  // final double? propertyLatitude;
  // final double? propertyLongitude;
  // final String? propertyTitle;

  LocationMapWidget({
    Key? key,
    required this.property,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
    // this.propertyLatitude,
    // this.propertyLongitude,
    // this.propertyTitle,
  }) : super(key: key);

  @override
  State<LocationMapWidget> createState() => _LocationMapWidgetState();
}

class _LocationMapWidgetState extends State<LocationMapWidget> {
  GoogleMapController? _controller;
  loc.LocationData? _currentLocation;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final loc.Location _location = loc.Location();
  bool _isLoading = true;
  Marker? _currentLocationMarker;
  Marker? _propertyMarker;
  LatLng? _currentLatLng;
  StreamSubscription<loc.LocationData>? _locationSubscription;
  LatLng _defaultLocation = const LatLng(30.0444, 31.2357); // Cairo
  double _zoomLevel = 15.0;

  @override
  void initState() {
    super.initState();
    _setupMap();
  }

  Future<void> _setupMap() async {
    await _getCurrentLocation();
    _addPropertyMarker();

    if (_currentLatLng != null && _propertyMarker != null) {
      _drawRoutesToProperty();
    }
  }

  void _addPropertyMarker() {
    if (widget.property.latitude != null && widget.property.longitude != null) {
      final propertyLocation = LatLng(
        widget.property.latitude!,
        widget.property.longitude!,
      );

      _propertyMarker = Marker(
        markerId: const MarkerId("property_location"),
        position: propertyLocation,
        infoWindow: InfoWindow(title: widget.property.title ?? "موقع العقار"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      _markers.add(_propertyMarker!);

      // Center the map on the property
      if (_controller != null) {
        _controller!.animateCamera(
          CameraUpdate.newLatLngZoom(propertyLocation, _zoomLevel),
        );
      }
    }
  }

  void _drawRoutesToProperty() {
    if (_currentLatLng != null && _propertyMarker != null) {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route_to_property"),
          color: Colors.blue,
          width: 3,
          points: [_currentLatLng!, _propertyMarker!.position],
        ),
      );
    }
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
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

    setState(() => _isLoading = true);
    try {
      _currentLocation = await _location.getLocation();
      if (_currentLocation != null) {
        _currentLatLng = LatLng(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        );
        _currentLocationMarker = Marker(
          markerId: const MarkerId("current_location"),
          position: _currentLatLng!,
          infoWindow: const InfoWindow(title: "موقعك الحالي"),
        );
        _markers.add(_currentLocationMarker!);
      }
    } catch (e) {
      print('Error getting current location: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToFullScreenMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SimpleMapScreen(
              propertyLatitude: widget.property.latitude,
              propertyLongitude: widget.property.longitude,
              propertyTitle: widget.property.title,
              initialZoom: _zoomLevel,
            ),
      ),
    );
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 1).clamp(0.0, 18.0);
      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.zoomTo(_zoomLevel));
      }
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 1).clamp(0.0, 18.0);
      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.zoomTo(_zoomLevel));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 0.3),
        Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Text(
            "تفاصيل الموقع على الخريطة",
            style: TextStyle(
              color: Colors.black,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w500,
              fontFamily: Fonts.primaryFontFamily,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: widget.padding),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:
                        widget.property.latitude != null &&
                                widget.property.longitude != null
                            ? LatLng(
                              widget.property.latitude!,
                              widget.property.longitude!,
                            )
                            : _currentLatLng ?? _defaultLocation,
                    zoom: _zoomLevel,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    _addPropertyMarker();
                  },
                  markers: _markers,
                  polylines: _polylines,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add, color: AppColors.primaryColor),
                        onPressed: _zoomIn,
                      ),
                      IconButton(
                        icon: Icon(Icons.remove, color: AppColors.primaryColor),
                        onPressed: _zoomOut,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// كلاس مبسط للخريطة بشاشة كاملة بدون استخدام GetNearestCubit
class SimpleMapScreen extends StatefulWidget {
  final double? propertyLatitude;
  final double? propertyLongitude;
  final String? propertyTitle;
  final double initialZoom;

  SimpleMapScreen({
    Key? key,
    this.propertyLatitude,
    this.propertyLongitude,
    this.propertyTitle,
    this.initialZoom = 15.0,
  }) : super(key: key);

  @override
  State<SimpleMapScreen> createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  GoogleMapController? _controller;
  loc.LocationData? _currentLocation;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final loc.Location _location = loc.Location();
  bool _isLoading = true;
  Marker? _currentLocationMarker;
  Marker? _propertyMarker;
  LatLng? _currentLatLng;
  LatLng _defaultLocation = const LatLng(30.0444, 31.2357); // Cairo
  StreamSubscription<loc.LocationData>? _locationSubscription;
  double _zoomLevel = 15.0;

  @override
  void initState() {
    super.initState();
    _zoomLevel = widget.initialZoom;
    _setupMap();
    _startTrackingUserLocation();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  void _startTrackingUserLocation() {
    _locationSubscription = _location.onLocationChanged.listen((
      loc.LocationData newLocation,
    ) {
      if (mounted) {
        setState(() {
          _currentLocation = newLocation;
          _currentLatLng = LatLng(
            newLocation.latitude!,
            newLocation.longitude!,
          );

          // تحديث علامة الموقع الحالي
          _markers.removeWhere(
            (m) => m.markerId == const MarkerId("current_location"),
          );
          _currentLocationMarker = Marker(
            markerId: const MarkerId("current_location"),
            position: _currentLatLng!,
            infoWindow: const InfoWindow(title: "موقعك الحالي"),
          );
          _markers.add(_currentLocationMarker!);

          // إعادة رسم المسار إلى العقار إذا كان موجوداً
          if (_propertyMarker != null) {
            _polylines.clear();
            _drawRoutesToProperty();
          }
        });
      }
    });
  }

  Future<void> _setupMap() async {
    await _getCurrentLocation();
    _addPropertyMarker();

    if (_currentLatLng != null && _propertyMarker != null) {
      _drawRoutesToProperty();
    }
  }

  void _addPropertyMarker() {
    if (widget.propertyLatitude != null && widget.propertyLongitude != null) {
      final propertyLocation = LatLng(
        widget.propertyLatitude!,
        widget.propertyLongitude!,
      );

      _propertyMarker = Marker(
        markerId: const MarkerId("property_location"),
        position: propertyLocation,
        infoWindow: InfoWindow(title: widget.propertyTitle ?? "موقع العقار"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      _markers.add(_propertyMarker!);

      // Center the map on the property
      if (_controller != null) {
        _controller!.animateCamera(
          CameraUpdate.newLatLngZoom(propertyLocation, _zoomLevel),
        );
      }
    }
  }

  void _drawRoutesToProperty() {
    if (_currentLatLng != null && _propertyMarker != null) {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route_to_property"),
          color: Colors.blue,
          width: 3,
          points: [_currentLatLng!, _propertyMarker!.position],
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        if (mounted) setState(() => _isLoading = false);
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        print('Location permission denied.');
        if (mounted) setState(() => _isLoading = false);
        return;
      }
    }

    if (mounted) setState(() => _isLoading = true);
    try {
      _currentLocation = await _location.getLocation();
      if (_currentLocation != null) {
        _currentLatLng = LatLng(
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        );
        _currentLocationMarker = Marker(
          markerId: const MarkerId("current_location"),
          position: _currentLatLng!,
          infoWindow: const InfoWindow(title: "موقعك الحالي"),
        );
        _markers.add(_currentLocationMarker!);
      }
    } catch (e) {
      print('Error getting current location: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 1).clamp(0.0, 18.0);
      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.zoomTo(_zoomLevel));
      }
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 1).clamp(0.0, 18.0);
      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.zoomTo(_zoomLevel));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.propertyTitle ?? "موقع العقار",
          style: TextStyle(fontSize: 16, fontFamily: Fonts.primaryFontFamily),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  widget.propertyLatitude != null &&
                          widget.propertyLongitude != null
                      ? LatLng(
                        widget.propertyLatitude!,
                        widget.propertyLongitude!,
                      )
                      : _currentLatLng ?? _defaultLocation,
              zoom: _zoomLevel,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              _addPropertyMarker();
            },
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            onTap: (LatLng position) {
              // يمكن إضافة وظائف إضافية عند النقر على الخريطة
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          Positioned(
            top: 50,
            right: 10,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: AppColors.primaryColor),
                  onPressed: _zoomIn,
                ),
                IconButton(
                  icon: Icon(Icons.remove, color: AppColors.primaryColor),
                  onPressed: _zoomOut,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_currentLatLng != null)
                  Text(
                    "Latitude: ${_currentLatLng!.latitude}",
                    style: TextStyle(color: Colors.black),
                  ),
                if (_currentLatLng != null)
                  Text(
                    "Longitude: ${_currentLatLng!.longitude}",
                    style: TextStyle(color: Colors.black),
                  ),
                if (widget.propertyLatitude != null &&
                    widget.propertyLongitude != null)
                  Text(
                    "Property Latitude: ${widget.propertyLatitude}",
                    style: TextStyle(color: Colors.black),
                  ),
                if (widget.propertyLatitude != null &&
                    widget.propertyLongitude != null)
                  Text(
                    "Property Longitude: ${widget.propertyLongitude}",
                    style: TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
