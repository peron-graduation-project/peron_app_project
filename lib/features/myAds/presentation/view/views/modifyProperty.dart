
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/myAds/presentation/view/widgets/dottedBorderBox.dart';
import 'package:peron_project/features/myAds/presentation/view/widgets/successDialog.dart';
import 'package:peron_project/features/payment/presentation/view/views/otp.dart';
import 'package:peron_project/features/payment/presentation/view/widgets/successDialogOTP.dart';

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 1),
                _buildTextField('نوع العقار'),
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
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                _buildTextField('المساحة (بالمتر)', height: 36),
                _buildTextField('السعر - جنيه', height: 36),
                _buildDropdown(
                  'تطل على',
                  ["شارع رئيسى", "شارع فرعي", "ناصيه", "خلفي", "أخري"],
                  selectedView,
                  (val) => setState(() => selectedView = val),
                ),
                _buildDropdown(
                  'طريقة الدفع',
                  ['نقدا  ', '  تقسيط', ' نقدا أو تقسيط'],
                  selectedPayment,
                  (val) => setState(() => selectedPayment = val),
                ),
                _buildTextField('الغرف', height: 36),
                _buildTextField('الحمامات', height: 36),
                _buildTextField('الطابق', height: 36),
                _buildTextField('المطبخ', height: 36),
                _buildDropdown(
                  'الحاله',
                  ["مجهزه", "مجهزه جزئيا", "غير مجهزه"],
                  selectedState,
                  (val) => setState(() => selectedState = val),
                ),
                _buildTextField('عنوان العقار', height: 36),
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
                          builder: (_) =>  SuccessDialog(),
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

  Widget _buildTextField(String label, {double height = 60, int maxline = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          SizedBox(
            height: maxline == 1 ? height : null,
            child: TextField(
              maxLines: maxline,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            items: items.map((item) {
              final isSelected = selectedValue == item;
              return DropdownMenuItem<String>(
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check,
                          color: AppColors.primaryColor, size: 20),
                  ],
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 2),
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

