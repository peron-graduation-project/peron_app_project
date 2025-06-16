import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_form3.dart';


class AddPropertyScreen3 extends StatelessWidget {
  final PropertyFormData data;
  const AddPropertyScreen3({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const CustomArrowBack(),
          centerTitle: true,
          title: Text(
            'أضف عقار',
            style: TextStyle(
              fontFamily: Fonts.primaryFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: sw * 0.053,
              height: 15.27 / 20,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: sh * 0.02,
            ),
            child: Column(
              children: [
                Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xFFE1E1E1),
                ),
                SizedBox(height: sh * 0.02),

                Center(
                  child: SvgPicture.asset(
                    Images.addPropertyTitle3,
                    width: sw * 0.4,
                    height: sh * 0.05,
                  ),
                ),
                SizedBox(height: sh * 0.02),

                PropertyForm3(formData: data),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
