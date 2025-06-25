import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final _formKey           = GlobalKey<FormState>();
  final bedroomsController = TextEditingController();
  final bathsController    = TextEditingController();
  final addressController  = TextEditingController();

  LatLng?  _pickedLatLng;
  String   _pickedAddress = '';
  GoogleMapController? _previewController;

  @override
  void dispose() {
    bedroomsController.dispose();
    bathsController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _openMap() async {
    final MapResult? result = await Navigator.push<MapResult>(
      context,
      MaterialPageRoute(builder: (_) => const PickLocationScreen()),
    );
    if (result != null) {
      setState(() {
        _pickedLatLng  = LatLng(result.latitude, result.longitude);
        _pickedAddress = result.address;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _previewController?.animateCamera(
          CameraUpdate.newLatLngZoom(_pickedLatLng!, 15),
        );
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
                if (v == null || v.trim().isEmpty) return 'يرجى إدخال عدد الغرف';
                if (int.tryParse(v) == null)      return 'رقم غير صحيح';
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
                if (v == null || v.trim().isEmpty) return 'يرجى إدخال عدد الحمامات';
                if (int.tryParse(v) == null)      return 'رقم غير صحيح';
                return null;
              },
            ),

            buildLabel('عنوان العقار', w),
            const SizedBox(height: 8),
            CustomTextField(
              controller: addressController,
              hintText: 'أدخل العنوان الكامل',
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'يرجى إدخال العنوان';
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
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _pickedLatLng!,
                            zoom: 15,
                          ),
                          onMapCreated: (ctrl) => _previewController = ctrl,
                          markers: {
                            Marker(
                              markerId: const MarkerId('preview'),
                              position: _pickedLatLng!,
                            )
                          },
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'متابعة',
                    textColor: AppColors.labelMediumColor,
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      if (!(_formKey.currentState?.validate() ?? false)) return;
                      if (_pickedLatLng == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('يرجى اختيار الموقع')),
                        );
                        return;
                      }
                      widget.formData
                        ..bedrooms  = int.parse(bedroomsController.text)
                        ..bathrooms = int.parse(bathsController.text)
                        ..latitude  = _pickedLatLng!.latitude
                        ..longitude = _pickedLatLng!.longitude
                        ..location  = _pickedAddress;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddPropertyScreen3(data: widget.formData),
                        ),
                      );
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
