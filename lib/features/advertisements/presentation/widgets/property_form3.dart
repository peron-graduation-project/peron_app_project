import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen4.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_date_picker_field.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_dropdown.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_multi_select_dropdown.dart';


class PropertyForm3 extends StatefulWidget {
  final PropertyFormData formData;
  const PropertyForm3({required this.formData, super.key});

  @override
  _PropertyForm3State createState() => _PropertyForm3State();
}

class _PropertyForm3State extends State<PropertyForm3> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedSpecs = [];
  String? selectedDuration;
  DateTime? startDate;
  DateTime? endDate;

  final List<String> specs = [
    'مصعد',
    'جراج',
    'بلكونه',
    'واي فاي',
    'تدفئه مركزيه',
    'حراسه',
  ];

  final List<String> durations = ['يومي', 'شهري', 'سنوي'];

  @override
  void initState() {
    super.initState();
    selectedSpecs = List.from(widget.formData.selectedFeatures);
    selectedDuration = widget.formData.rentType.isNotEmpty ? widget.formData.rentType : null;
    startDate = widget.formData.availableFrom;
    endDate = widget.formData.availableTo;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار تاريخ البداية وتاريخ الانتهاء')),
      );
      return;
    }

    widget.formData.selectedFeatures = selectedSpecs;
    widget.formData.rentType = selectedDuration!;
    widget.formData.availableFrom = startDate!;
    widget.formData.availableTo = endDate!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddPropertyScreen4(data: widget.formData),
      ),
    );
  }

  Widget _buildLabel(String text, double sw) {
    return Padding(
      padding: EdgeInsets.only(top: sw * 0.03),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: sw * 0.04,
          fontFamily: Fonts.primaryFontFamily,
          color: AppColors.titleSmallColor,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('مواصفات أخرى', sw),
          const SizedBox(height: 8),
          CustomMultiSelectDropdown(
            label: 'اختر المواصفات',
            selectedValues: selectedSpecs,
            items: specs,
            onChanged: (vals) => setState(() => selectedSpecs = vals),
          ),

          _buildLabel('مدة الإيجار', sw),
          const SizedBox(height: 8),
          CustomDropdown(
            label: 'اختر المدة',
            value: selectedDuration,
            items: durations,
            onChanged: (v) => setState(() => selectedDuration = v),
            validator: (v) => v == null ? 'يرجى اختيار المدة' : null,
          ),

          _buildLabel('بداية الحجز من', sw),
          const SizedBox(height: 8),
          CustomDatePickerField(
            hintText: 'اختر تاريخ البداية',
            initialDate: startDate,
            onDateSelected: (date) => setState(() => startDate = date),
          ),

          _buildLabel('الى', sw),
          const SizedBox(height: 8),
          CustomDatePickerField(
            hintText: 'اختر تاريخ الانتهاء',
            initialDate: endDate,
            onDateSelected: (date) => setState(() => endDate = date),
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'التالي',
                  textColor: AppColors.labelMediumColor,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: _submit,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'السابق',
                  textColor: AppColors.primaryColor,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColor,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
