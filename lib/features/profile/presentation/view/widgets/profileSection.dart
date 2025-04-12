import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../../manager/get profile/get_profile_cubit.dart';
import '../../manager/get profile/get_profile_state.dart';

class ProfileSection extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const ProfileSection({super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  String? _selectedImagePath;

  Future<void> _showOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.image),
                title: const Text('عرض صورة'),
                onTap: () {
                  Navigator.pop(context);
                  _displayProfileImage(context);
                }),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('تحميل صورة'),
              onTap: () async {
                Navigator.pop(context);
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _selectedImagePath = image.path;
                  });
                  print('تم اختيار صورة: ${image.path}');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _displayProfileImage(BuildContext context) {
    String? profileImageUrl;
    final state = BlocProvider.of<GetProfileCubit>(context).state;
    if (state is GetProfileLoaded) {
      profileImageUrl = state.profile.profilePictureUrl;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.black.withOpacity(0.8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (profileImageUrl != null && profileImageUrl.isNotEmpty)
                InteractiveViewer(
                  panEnabled: false,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  minScale: 0.5,
                  maxScale: 2.0,
                  child: Image.network(
                    profileImageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('فشل في تحميل الصورة', style: TextStyle(color: Colors.white));
                    },
                  ),
                )
              else
                Image.asset(
                  "assets/images/no pic.jpg",
                  fit: BoxFit.contain,
                ),
              Positioned(
                top: 16.0,
                left: 16.0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          String profileName = "";

          if (state is GetProfileLoaded) {
            profileName = state.profile.fullName ?? "اسم المستخدم";
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: widget.screenWidth * 0.15,
                    backgroundImage: _selectedImagePath != null
                        ? FileImage(File(_selectedImagePath!)) as ImageProvider
                        : (state is GetProfileLoaded && state.profile.profilePictureUrl != null
                        ? NetworkImage(state.profile.profilePictureUrl!) as ImageProvider
                        : const AssetImage("assets/images/no pic.jpg") as ImageProvider),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => _showOptions(context),
                      child: CircleAvatar(
                        radius: widget.screenWidth * 0.039,
                        backgroundColor: const Color.fromARGB(255, 195, 193, 193),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.black,
                          size: widget.screenWidth * 0.05,
                        ),
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
  }}