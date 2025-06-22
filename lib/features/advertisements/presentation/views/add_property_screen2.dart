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
  const AddPropertyScreen2({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).textTheme;


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'أضف عقار',
            style: theme.headlineMedium!.copyWith(fontSize: 20),
          ),
          leading: CustomArrowBack(),
          automaticallyImplyLeading: false,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.dividerColor,
            ),
          ),
        ),

        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
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
    );
  }
}
