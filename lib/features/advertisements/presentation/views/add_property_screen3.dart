import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/data/repo/property_confirm/property_confirm_repo_imp.dart';
import 'package:peron_project/features/advertisements/data/repo/property_pending/property_pending_repo_imp.dart';
import 'package:peron_project/features/advertisements/presentation/manager/propert_confirm/property_confirm_cubit.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_form3.dart';

import '../../../../core/network/api_service.dart';
import '../../data/repo/property_confirm/property_confirm_repo.dart';
import '../manager/property_pending/property_pending_cubit.dart';

class AddPropertyScreen3 extends StatelessWidget {
  final PropertyFormData data;
  const AddPropertyScreen3({required this.data, super.key});

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
    ),),
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

              SizedBox(height: sh * 0.02),

              Center(
                child: SvgPicture.asset(
                  Images.addPropertyTitle3,
                  width: sw * 0.4,
                  height: sh * 0.05,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.04,
                  vertical: sh * 0.02,
                ),
                child: PropertyForm3(formData: data),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
