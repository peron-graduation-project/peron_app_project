import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';

import '../../manager/get profile/get_profile_cubit.dart';
import '../../manager/get profile/get_profile_state.dart';

class ProfileSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const ProfileSection({super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          String? profileImageUrl;
          String profileName = "";

          if (state is GetProfileLoaded) {
            profileImageUrl = state.profile.profilePictureUrl;
            profileName = state.profile.fullName ?? "اسم المستخدم";
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.15,
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl) as ImageProvider
                        : const AssetImage("assets/images/no pic.jpg") as ImageProvider,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: CircleAvatar(
                      radius: screenWidth * 0.039,
                      backgroundColor: const Color.fromARGB(255, 195, 193, 193),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.black,
                        size: screenWidth * 0.05,
                      ),
                    ),
                  ),
                  if (state is GetProfileLoading)
                     Positioned.fill(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  if (state is GetProfileError)
                    Positioned.fill(
                      child: Center(
                        child: Text('Failed to load profile: ${state.message}', style: const TextStyle(color: Colors.red)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                  profileName,
                  style: theme.bodyMedium?.copyWith(color: const Color(0xff282929))),
            ],
          );
        },
      ),
    );
  }
}