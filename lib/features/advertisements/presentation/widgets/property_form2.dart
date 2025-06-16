import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen3.dart';
import 'package:peron_project/features/advertisements/presentation/views/pick_location_screen.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_text_field2.dart';


class PropertyForm2 extends StatefulWidget {
  final PropertyFormData formData;
  const PropertyForm2({Key? key, required this.formData}) : super(key: key);

  @override
  _PropertyForm2State createState() => _PropertyForm2State();
}

class _PropertyForm2State extends State<PropertyForm2> {
  final _formKey = GlobalKey<FormState>();
  final bedroomsController = TextEditingController();
  final bathsController = TextEditingController();
  final addressController = TextEditingController();

  LatLng? _pickedLatLng;
  String _pickedAddress = '';

  
  final MapController _previewMapController = MapController();

  @override
  void dispose() {
    bedroomsController.dispose();
    bathsController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _openMap() async {
    final result = await Navigator.push<MapResult>(
      context,
      MaterialPageRoute(builder: (_) => const PickLocationScreen()),
    );
    if (result != null) {
      final newLatLng = LatLng(result.latitude, result.longitude);
      setState(() {
        _pickedLatLng = newLatLng;
        _pickedAddress = result.address;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pickedLatLng != null) {
          try {
            _previewMapController.move(_pickedLatLng!, 15);
          } catch (_) {
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel('الغرف', w),
            const SizedBox(height: 8),
            CustomTextField(
              controller: bedroomsController,
              hintText: 'أدخل عدد الغرف',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'يرجى إدخال عدد الغرف';
                }
                if (int.tryParse(v) == null) {
                  return 'رقم غير صحيح';
                }
                return null;
              },
            ),

            buildLabel('الحمامات', w),
            const SizedBox(height: 8),
            CustomTextField(
              controller: bathsController,
              hintText: 'أدخل عدد الحمامات',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'يرجى إدخال عدد الحمامات';
                }
                if (int.tryParse(v) == null) {
                  return 'رقم غير صحيح';
                }
                return null;
              },
            ),

            buildLabel('عنوان العقار', w),
            const SizedBox(height: 8),
            CustomTextField(
              controller: addressController,
              hintText: 'أدخل العنوان الكامل',
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'يرجى إدخال العنوان';
                }
                return null;
              },
            ),

            buildLabel('العنوان على الخريطة', w),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _openMap,
              child: Container(
                height: h * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _pickedLatLng == null
                    ? Center(
                        child: Text(
                          'اضغط لاختيار الموقع',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : Builder(
                        builder: (context) {
                          final latLng = _pickedLatLng!;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                AbsorbPointer(
                                  absorbing: true,
                                  child: FlutterMap(
                                    mapController: _previewMapController,
                                    options: MapOptions(
                                      initialCenter: latLng,
                                      initialZoom: 15,
                                      
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        subdomains: const ['a', 'b', 'c'],
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point: latLng,
                                            width: 48,
                                            height: 48,
                                            child: const Icon(
                                              Icons.location_on,
                                              size: 48,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.white.withOpacity(0.8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          _pickedAddress,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '(${latLng.latitude.toStringAsFixed(4)}, ${latLng.longitude.toStringAsFixed(4)})',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text:'التالى',
                    textColor: AppColors.labelMediumColor,
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (_pickedLatLng == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('يرجى اختيار الموقع')),
                          );
                          return;
                        }
                        widget.formData
                          ..bedrooms = int.parse(bedroomsController.text)
                          ..bathrooms = int.parse(bathsController.text)
                          ..latitude = _pickedLatLng!.latitude
                          ..longitude = _pickedLatLng!.longitude
                          ..location = _pickedAddress;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AddPropertyScreen3(data: widget.formData),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'السابق',
                    textColor: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primaryColor,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text, double w) => Padding(
        padding: EdgeInsets.only(top: w * 0.03),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: w * 0.04,
            fontFamily: Fonts.primaryFontFamily,
            color: AppColors.titleSmallColor,
          ),
        ),
      );
}
