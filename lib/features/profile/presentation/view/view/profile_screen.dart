import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/profile/domain/repos/change%20password/change_password_repo_imp.dart';
import 'package:peron_project/features/profile/presentation/manager/get%20profile/get_profile_cubit.dart';
import 'package:peron_project/features/profile/presentation/manager/get%20profile/get_profile_state.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/accountOption.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/change_password_dialog.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/profileSection.dart';

import '../../manager/change password/change_password_cubit.dart';
import '../../manager/update profile/update_profile_cubit.dart';
import '../widgets/change_user_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver {
  String? _editedFullName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfile();
  }

  void _loadProfile() {
    context.read<GetProfileCubit>().getProfile();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => ChangePasswordCubit(ChangePasswordRepoImp(ApiService(Dio()))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "الملف الشخصي",
            style: theme.headlineMedium!.copyWith(fontSize: 20),
          ),
          centerTitle: true,
          leading: CustomArrowBack(
          ),
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
            print('ProfileScreen: BlocBuilder تم بناؤه مع State: $state');
            if (state is GetProfileLoading) {
              print('ProfileScreen: State is GetProfileLoading');
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
            } else if (state is GetProfileError) {
              print('ProfileScreen: State is GetProfileError: ${state.message}');
              return Center(child: Text('فشل في تحميل البروفايل: ${state.message}', style: const TextStyle(color: Colors.red)));
            } else if (state is GetProfileLoaded) {
              print('ProfileScreen: State is GetProfileLoaded - Full Name: ${state.profile.fullName}, Image URL: ${state.profile.profilePictureUrl}');
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    ProfileSection(
                      isShown: true,
                      key: ValueKey(state.profile.profilePictureUrl),
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final newName = await showChangeUserNameDialog(
                          context,
                          _editedFullName ?? state.profile.fullName ?? "اسم المستخدم",
                        );
                        if (newName != null && newName != state.profile.fullName) {
                          setState(() {
                            _editedFullName = newName;
                          });
                          BlocProvider.of<UpdateProfileCubit>(context, listen: false)
                              .updateProfile(
                            profilePicture: '',
                            fullName: newName,
                          ).then((_) {
                            context.read<GetProfileCubit>().getProfile();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم تحديث البروفايل بنجاح')),
                            );
                          });
                        }
                      },
                      child: AccountOption(
                        icon: Icons.person,
                        title: _editedFullName ?? state.profile.fullName ?? "اسم المستخدم",
                        screenWidth: screenWidth,
                      ),
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
              print('ProfileScreen: State is Unknown: $state');
              return Center(child: CircularProgressIndicator(
                color:AppColors.primaryColor ,
              ));
            }
          },
        ),
      ),
    );
  }
}