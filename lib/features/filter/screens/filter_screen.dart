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
    double? min = double.tryParse(minController.text);
    double? max = double.tryParse(maxController.text);

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
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      if (token.isEmpty) {
        print('التوكن غير موجود، تأكد من تسجيل الدخول');
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
        print('يرجى تحديد بعض الفلاتر أولاً');
        return;
      }

      final filteredProperties = await FilterApi.getFilteredProperties(
        location: selectedLocation,
        minPrice: minPrice ?? 0,
        maxPrice: maxPrice ?? 999999,
        rentType: isMonthly == null ? null : (isMonthly! ? 'شهري' : 'يومي'),
        area: 100,
        bedrooms: rooms,
        bathrooms: bathrooms,
        floor: floors,
        minRating: rating?.toDouble(),
        isFurnished: furnitureStatus == null ? null : (furnitureStatus == "مجهزة"),
        hasBalcony: selectedServices.contains('شرفة'),
        hasInternet: selectedServices.contains('انترنت'),
        hasSecurity: selectedServices.contains('أمن'),
        hasElevator: selectedServices.contains('مصعد'),
        allowsPets: allowPets,
        smokingAllowed: selectedServices.contains('تدخين'),
        minBookingDays: 1,
        availableFrom: selectedDate?.toIso8601String(),
        token: token,
      );

      print(filteredProperties);
    } catch (e) {
      print('خطأ أثناء الفلترة: $e');
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
                  onChanged: (value) => setState(() => selectedLocation = value),
                ),
                RentalDurationSection(
                  isMonthly: isMonthly,
                  onChanged: (value) => setState(() => isMonthly = value),
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
                  onRoomsChanged: (value) => setState(() => rooms = value),
                  onBathroomsChanged: (value) => setState(() => bathrooms = value),
                  onFloorsChanged: (value) => setState(() => floors = value),
                  onRatingChanged: (value) => setState(() => rating = value),
                ),
                FurnitureStatusSection(
                  furnitureStatus: furnitureStatus,
                  onChanged: (value) => setState(() => furnitureStatus = value),
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
                  onChanged: (value) => setState(() => allowPets = value),
                ),
                BookingDateSection(
                  selectedDate: selectedDate,
                  onDateSelected: (date) => setState(() => selectedDate = date),
                ),
                SubmitButtonSection(
                  onPressed: applyFilters,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
