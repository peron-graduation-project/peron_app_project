import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/myAds/presentation/view/widgets/dottedBorderBox.dart';
import 'package:peron_project/features/myAds/presentation/view/widgets/successDialog.dart';
import 'package:peron_project/features/profile/presentation/view/view/profile_screen.dart';

class EditPropertyScreen extends StatefulWidget {
  const EditPropertyScreen({super.key});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  String? selectedLocation;
  String? selectedView;
  String? selectedState;
  String? selectedPayment;
  String selectedPhoneCode = '+20';
  bool allowPets = false;
  bool acceptAllTerms = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController propertyTypeController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController youtubeLinkController = TextEditingController();
  final TextEditingController spaceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController kitchenController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: CustomArrowBack(),
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
                youtubeLinkController.clear();
                spaceController.clear();
                priceController.clear();
                roomsController.clear();
                bathroomsController.clear();
                floorController.clear();
                kitchenController.clear();
                addressController.clear(); 
              });
            },
            child: Text(
              "مسح",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 1),
                _buildTextField('نوع العقار', propertyTypeController),
                _buildDropdown(
                  'المكان',
                  [
                    "حى الجامعه",
                    "قناه السويس",
                    "توريل",
                    "الجلاء",
                    "المشايه",
                    "الترعه",
                    "الصنيه",
                    "الاتوبيس",
                    "عبدالسلام عارف",
                  ],
                  selectedLocation,
                  (val) => setState(() => selectedLocation = val),
                ),
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
                  child: TextField(
                    controller: detailsController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
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
                  ),
                ),
                const SizedBox(height: 16),
                IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'الهاتف',
                    labelStyle: GoogleFonts.tajawal(
                      fontSize: screenWidth * 0.04,
                      color: AppColors.black,
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
                  initialCountryCode: 'EG',
                  dropdownIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black54,
                    size: 24,
                  ),
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
              
              
                const SizedBox(height: 8),
                _buildTextField(
                  'المساحة (بالمتر)',
                  spaceController,
                  height: 36,
                ),
                _buildTextField('السعر - جنيه', priceController, height: 36),
              
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
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
                        scale: 0.9,
                        child: Switch(
                          value: allowPets,
                          activeColor: Colors.white,
                          activeTrackColor: AppColors.primaryColor,
                          inactiveThumbColor: Colors.white,
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
                _buildTextField('الغرف', roomsController, height: 36),
                _buildTextField('الحمامات', bathroomsController, height: 36),
                _buildTextField('عنوان العقار', addressController, height: 36),
                
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
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => SuccessDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: const Text(
                        'نشر',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    double height = 60,
    int maxline = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          SizedBox(
            height: maxline == 1 ? height : null,
            child: TextField(
              controller: controller,
              maxLines: maxline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
            value: selectedValue,
            onChanged: onChanged,
            items:
                items.map((item) {
                  final isSelected = selectedValue == item;
                  return DropdownMenuItem<String>(
                    value: item,
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
                        if (isSelected)
                          Icon(
                            Icons.check,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                      ],
                    ),
                  );
                }).toList(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
            ),
            selectedItemBuilder: (context) {
              return items.map((item) {
                return Text(
                  item,
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
              maxHeight: double.infinity,
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
