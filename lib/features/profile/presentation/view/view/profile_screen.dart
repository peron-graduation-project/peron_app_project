import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/profile/presentation/manager/get%20profile/get_profile_cubit.dart'; // استوردنا الـ Cubit
import 'package:peron_project/features/profile/presentation/manager/get%20profile/get_profile_state.dart'; // استوردنا الـ State
import 'package:peron_project/features/profile/presentation/view/widgets/accountOption.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/change_password_dialog.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/profileSection.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الملف الشخصي",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        leading: CustomArrowBack(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),
      ),
      body: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoading) {
            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          } else if (state is GetProfileError) {
            return Center(child: Text('فشل في تحميل البروفايل: ${state.message}', style: const TextStyle(color: Colors.red)));
          } else if (state is GetProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  ProfileSection(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  AccountOption(
                    icon: Icons.person,
                    title: state.profile.fullName ?? "اسم المستخدم",
                    screenWidth: screenWidth,
                  ),
                  AccountOption(
                    icon: Icons.email_outlined,
                    title: state.profile.email ?? "البريد الإلكتروني",
                    screenWidth: screenWidth,
                  ),
                  GestureDetector(
                    onTap: () {
                      showChangePasswordDialog(context);
                    },
                    child: AccountOption(
                        icon: Icons.lock,
                        title: 'تغير كلمة المرور',
                        screenWidth: screenWidth),
                  ),
                ],
              ),
            );
          } else {
            return  Center(child: CircularProgressIndicator(
              color:AppColors.primaryColor ,
            ));
          }
        },
      ),
    );
  }
}