import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/data/repo/property_pending/property_pending_repo_imp.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_form4.dart';

import '../../../../core/network/api_service.dart';
import '../manager/property_pending/property_pending_cubit.dart';

class AddPropertyScreen4 extends StatelessWidget {
  final PropertyFormData data;
  const AddPropertyScreen4({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).textTheme;


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
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create:
                          (context) => PropertyPendingCubit(
                            PropertyPendingRepoImp(ApiService(Dio())),
                          ),
                    ),
                  ],
                  child: PropertyForm4(formData: data),
                     ),
          ),
        ),
      ),
    );
  }
}