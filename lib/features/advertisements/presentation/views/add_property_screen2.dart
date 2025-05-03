import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_form2.dart';

class AddPropertyScreen2 extends StatelessWidget {
  final PropertyFormData data;
  const AddPropertyScreen2({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: sh * 0.06,
                    right: 16, left: 16,
                  ),
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: CustomArrowBack(),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'أضف عقار',
                          style: TextStyle(
                            fontFamily: Fonts.primaryFontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: sw * 0.053,
                            height: 15.27 / 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: sh * 0.025),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xFFE1E1E1),
                  ),
                ),
                SizedBox(height: sh * 0.03),
                Center(
                  child: SvgPicture.asset(
                    Images.addPropertyTitle2,
                    width: sw * 0.4,
                    height: sh * 0.05,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.04,
                    vertical: sh * 0.02,
                  ),
                  child: PropertyForm2(formData: data),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
