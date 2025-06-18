import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/myAds/presentation/view/widgets/dottedBorderBox.dart';
import 'package:peron_project/features/myAds/presentation/view/widgets/successDialog.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../../authentication/presentation/view/widgets/phone_field.dart';
import '../../manager/update property/update_property_cubit.dart';
import '../../manager/update property/update_property_state.dart';


class EditPropertyScreen extends StatefulWidget {
  final Property property;
  const EditPropertyScreen({super.key, required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedLocation;
  String? selectedView;
  String? selectedState;
  String? selectedPayment;
  String selectedPhoneCode = '+20';
  bool? allowPets ;
  bool acceptAllTerms = false;
  List<String> selectedValues = [];

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController propertyTypeController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController spaceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController kitchenController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController specificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    propertyTypeController.text = widget.property.rentType ?? '';
    detailsController.text = widget.property.description ?? '';
    locationController.text = widget.property.location ?? '';
    priceController.text = widget.property.price.toString() ?? '';
    spaceController.text = widget.property.area.toString() ?? '';
    specificationController.text = widget.property.description.toString() ?? '';
    roomsController.text = widget.property.bedrooms.toString() ?? '';
    bathroomsController.text = widget.property.bathrooms.toString() ?? '';
    floorController.text = widget.property.floor.toString() ?? '';
    allowPets = widget.property.allowsPets ?? false;

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).textTheme;

    return BlocConsumer<UpdatePropertyCubit, UpdatePropertyState>(
  listener: (context, state) {
    if (state is UpdatePropertyStateSuccess) {
      showDialog(
        context: context,
        builder: (_) => SuccessDialog(),
      );
    }
    else if (state is UpdatePropertyStateFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: ${state.errorMessage}')),
      );
    }

    },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrowBack(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),
        title: Text(
          'تعديل العقار',
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        elevation: 1,
        foregroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedValues.clear();
                selectedLocation = null;
                selectedView = null;
                selectedState = null;
                selectedPayment = null;
                selectedPhoneCode = '+20';
                allowPets = false;
                acceptAllTerms = false;
                phoneController.clear();
                propertyTypeController.clear();
                detailsController.clear();
                locationController.clear();
                spaceController.clear();
                priceController.clear();
                roomsController.clear();
                bathroomsController.clear();
                floorController.clear();
                kitchenController.clear();
                addressController.clear();
                specificationController.clear();
              });
            },
            child: Text(
              "مسح",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10,),
              Text(
                "نوع العقار",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField('نوع العقار', propertyTypeController),
              SizedBox(height: 10,),
              Text(
                "المكان",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField('المكان', locationController),
              const SizedBox(height: 8),
              Text(
                "تفاصيل الإعلان",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: screenHeight * 0.15,
                child: TextFormField(
                  controller: detailsController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: widget.property.description,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال التفاصيل';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8),
              PhoneFieldInput(controller: phoneController),
              const SizedBox(height: 8),
              Text(
                "المساحة (بالمتر)",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField('المساحة (بالمتر)', spaceController, ),
              SizedBox(height: 10,),
              Text(
                "السعر - جنيه",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField('السعر - جنيه', priceController,),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'السماح بوجود حيوانات أليفة',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: allowPets??false,
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.primaryColor,
                        inactiveThumbColor:AppColors.primaryColor,
                        inactiveTrackColor: Colors.grey.shade400,
                        onChanged: (val) {
                          setState(() {
                            allowPets = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "الغرف",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField('الغرف', roomsController, ),
              SizedBox(height: 10,),
              Text(
                "الحمامات",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField('الحمامات', bathroomsController, ),
              SizedBox(height: 10,),
              Text(
                "عنوان العقار",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),

              _buildTextField('عنوان العقار', addressController, ),
              
              _buildCheckboxDropdown(
                'مواصفات أخرى',
                [
                  "مصعد",
                  'جراج',
                  'بلكونه',
                  'واي فاي',
                  'تدفئه مركزيه',
                  'حراسه',
                ],
                selectedValues,
                    (val) => setState(() => selectedValues = val),
              ),
              const SizedBox(height: 8),
              const Text(
                'أضف صور العقار',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              DottedBorderBox(screenHeight: screenHeight),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.6,
                  height: 48,
                  child: CustomButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed:state is UpdatePropertyStateLoading?null:(){
                      if (_formKey.currentState!.validate()) {
                        Property newProperty=Property(
                          images: [],
                            description:specificationController.text,
                            price: double.parse(priceController.text),
                            area:  int.parse(spaceController.text),
                            location: addressController.text,
                            rentType: propertyTypeController.text,
                        bathrooms: int.parse(bathroomsController.text),
                        bedrooms: int.parse(roomsController.text),
                        floor: int.parse(floorController.text ),
                            allowsPets: allowPets,
                        );
                        final int propertyId = widget.property.propertyId!;
                        context.read<UpdatePropertyCubit>().updateProperty(
                          property: newProperty,
                          id: propertyId,
                        );
                      }
                    }, textColor: Colors.white, text: 'نشر',
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  },
);
  }

  Widget _buildTextField(
      String label, TextEditingController controller,
      {double? height}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: height ?? 56,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال $label';
            }
            return null;
          },
        ),
      ),
    );
  }



  Widget _buildCheckboxDropdown(
      String label,
      List<String> items,
      List<String> selectedValues,
      void Function(List<String>) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField2<String>(
            isExpanded: true,
            value: null,
            onChanged: (_) {},
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            hint: Text(
              selectedValues.isEmpty ? '' : selectedValues.join(" / "),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            items:
            items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, innerSetState) {
                    final isSelected = selectedValues.contains(item);
                    return InkWell(
                      onTap: () {
                        innerSetState(() {
                          if (isSelected) {
                            selectedValues.remove(item);
                          } else {
                            selectedValues.add(item);
                          }
                          onChanged(List.from(selectedValues));
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item,
                            style: TextStyle(
                              color:
                              isSelected
                                  ? AppColors.primaryColor
                                  : Colors.black,
                              fontWeight:
                              isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) {
                              innerSetState(() {
                                if (isSelected) {
                                  selectedValues.remove(item);
                                } else {
                                  selectedValues.add(item);
                                }
                                onChanged(List.from(selectedValues));
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            activeColor: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            selectedItemBuilder: (context) {
              return items.map((item) {
                return Text(
                  selectedValues.join(" / "),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                );
              }).toList();
            },
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              offset: const Offset(-140, 8),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }
}