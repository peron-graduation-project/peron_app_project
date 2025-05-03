import 'package:flutter/material.dart';
import 'package:peron_project/features/filter/services/filter_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/header_section.dart';
import '../widgets/location_section.dart';
import '../widgets/rental_duration_section.dart';
import '../widgets/price_range_section.dart';
import '../widgets/room_details_section.dart';
import '../widgets/furniture_status_section.dart';
import '../widgets/additional_services_section.dart';
import '../widgets/allow_pets_section.dart';
import '../widgets/booking_date_section.dart';
import '../widgets/submit_button_section.dart';
import 'available_apartments_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedLocation;
  bool? isMonthly;
  double? minPrice;
  double? maxPrice;
  int? rooms;
  int? bathrooms;
  int? floors;
  int? rating;
  String? furnitureStatus;
  bool allowPets = false;
  DateTime? selectedDate;
  List<String> selectedServices = [];

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  void updateRangeSlider() {
    final min = double.tryParse(minController.text);
    final max = double.tryParse(maxController.text);
    if (min != null && max != null && min >= 500 && max <= 20000 && min <= max) {
      setState(() {
        minPrice = min;
        maxPrice = max;
      });
    }
  }

  void resetFilters() {
    setState(() {
      selectedLocation = null;
      isMonthly = null;
      minPrice = null;
      maxPrice = null;
      rooms = null;
      bathrooms = null;
      floors = null;
      rating = null;
      furnitureStatus = null;
      allowPets = false;
      selectedDate = null;
      selectedServices.clear();
      minController.clear();
      maxController.clear();
    });
  }

  void applyFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('خطأ فى  بتسجيل الدخول ')),
      );
      return;
    }

    if (selectedLocation == null &&
        isMonthly == null &&
        minPrice == null &&
        maxPrice == null &&
        rooms == null &&
        bathrooms == null &&
        floors == null &&
        rating == null &&
        furnitureStatus == null &&
        selectedDate == null &&
        selectedServices.isEmpty &&
        !allowPets) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تحديد بعض الفلاتر أولاً')),
      );
      return;
    }

    final params = <String, dynamic>{};
    if (selectedLocation != null) params['Location'] = selectedLocation;
    if (minPrice != null) params['MinPrice'] = minPrice;
    if (maxPrice != null) params['MaxPrice'] = maxPrice;
    if (isMonthly != null) params['RentType'] = isMonthly! ? 'Monthly' : 'Daily';
    if (rooms != null) params['Bedrooms'] = rooms;
    if (bathrooms != null) params['Bathrooms'] = bathrooms;
    if (floors != null) params['Floor'] = floors;
    if (rating != null) params['MinRating'] = rating!.toDouble();
    if (furnitureStatus != null) params['IsFurnished'] = (furnitureStatus == 'مجهزة');
    if (selectedServices.contains('شرفة')) params['HasBalcony'] = true;
    if (selectedServices.contains('انترنت')) params['HasInternet'] = true;
    if (selectedServices.contains('أمن')) params['HasSecurity'] = true;
    if (selectedServices.contains('مصعد')) params['HasElevator'] = true;
    if (allowPets) params['AllowsPets'] = true;
    if (selectedServices.contains('تدخين')) params['SmokingAllowed'] = true;
    if (selectedDate != null) {
      params['AvailableFrom'] = selectedDate!.toIso8601String().split('T').first;
    }

    try {
      final filteredProperties = await FilterApi.getFilteredProperties(
        queryParams: params,
        token: token,
      );
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PropertiesScreen(filteredProperties: filteredProperties),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء الفلترة: \$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(resetFilters: resetFilters),
                LocationSection(
                  selectedLocation: selectedLocation,
                  onChanged: (v) => setState(() => selectedLocation = v),
                ),
                RentalDurationSection(
                  isMonthly: isMonthly,
                  onChanged: (v) => setState(() => isMonthly = v),
                ),
                PriceRangeSection(
                  minPrice: minPrice ?? 500,
                  maxPrice: maxPrice ?? 20000,
                  minController: minController,
                  maxController: maxController,
                  updateRangeSlider: updateRangeSlider,
                ),
                RoomDetailsSection(
                  rooms: rooms ?? 1,
                  bathrooms: bathrooms ?? 1,
                  floors: floors ?? 1,
                  rating: rating ?? 1,
                  onRoomsChanged: (v) => setState(() => rooms = v),
                  onBathroomsChanged: (v) => setState(() => bathrooms = v),
                  onFloorsChanged: (v) => setState(() => floors = v),
                  onRatingChanged: (v) => setState(() => rating = v),
                ),
                FurnitureStatusSection(
                  furnitureStatus: furnitureStatus,
                  onChanged: (v) => setState(() => furnitureStatus = v),
                ),
                AdditionalServicesSection(
                  selectedServices: selectedServices,
                  onToggle: (service) {
                    setState(() {
                      if (selectedServices.contains(service)) {
                        selectedServices.remove(service);
                      } else {
                        selectedServices.add(service);
                      }
                    });
                  },
                ),
                AllowPetsSection(
                  allowPets: allowPets,
                  onChanged: (v) => setState(() => allowPets = v),
                ),
                BookingDateSection(
                  selectedDate: selectedDate,
                  onDateSelected: (d) => setState(() => selectedDate = d),
                ),
                SubmitButtonSection(onPressed: applyFilters),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
