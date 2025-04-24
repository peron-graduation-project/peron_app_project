import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../manager/get profile/get_profile_cubit.dart';
import '../../manager/get profile/get_profile_state.dart';
import '../../manager/update profile/update_profile_cubit.dart';
import '../../manager/update profile/update_profile_state.dart';

class ProfileSection extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isShown;

  const ProfileSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.isShown,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  String? _selectedImagePath;
  String? _oldProfileImageUrl;

  Future<void> _showOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('عرض صورة'),
              onTap: () {
                Navigator.pop(context);
                _displayProfileImage(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('تحميل صورة'),
              onTap: () async {
                Navigator.pop(context);
                final picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    _selectedImagePath = image.path;
                  });

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('profileImagePath', image.path);

                  BlocProvider.of<UpdateProfileCubit>(context).updateProfile(
                    profilePicture: image.path,
                    fullName: '',
                    phoneNumber: ''
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _displayProfileImage(BuildContext context) {
    final state = context.read<GetProfileCubit>().state;
    String? profileImageUrl;
    if (state is GetProfileLoaded) {
      profileImageUrl = state.profile.profilePictureUrl;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.black.withOpacity(0.8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (profileImageUrl != null && profileImageUrl.isNotEmpty)
                InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: profileImageUrl,
                    fit: BoxFit.contain,
                  ),
                )
              else
                Image.asset(
                  "assets/images/no pic.jpg",
                  fit: BoxFit.contain,
                ),
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
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
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) async {
          if (state is UpdateProfileStateSuccess) {
            context.read<GetProfileCubit>().getProfile();

            if (_oldProfileImageUrl != null) {
              await CachedNetworkImage.evictFromCache(_oldProfileImageUrl!);
            }

            setState(() {
              _selectedImagePath = null;
              _oldProfileImageUrl = null;
            });
          } else if (state is UpdateProfileStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('فشل في تحديث البروفايل: ${state.errorMessage}')),
            );
          }
        },
        child: BlocBuilder<GetProfileCubit, GetProfileState>(
          builder: (context, state) {
            String profileName = "اسم غير متوفر";
            String? profileImageUrl;

            if (state is GetProfileLoaded) {
              profileName = state.profile.fullName ?? profileName;
              profileImageUrl = state.profile.profilePictureUrl;

              if (_oldProfileImageUrl != profileImageUrl) {
                _oldProfileImageUrl = profileImageUrl;
              }
            }

            ImageProvider? imageProvider;
            if (_selectedImagePath != null) {
              imageProvider = FileImage(File(_selectedImagePath!));
            } else if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
              imageProvider = CachedNetworkImageProvider(profileImageUrl);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: widget.screenWidth * 0.17,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: _selectedImagePath != null
                            ? Image.file(
                          File(_selectedImagePath!),
                          fit: BoxFit.cover,
                          width: widget.screenWidth * 0.34,
                          height: widget.screenWidth * 0.34,
                        )
                            : (profileImageUrl != null && profileImageUrl.isNotEmpty
                            ? CachedNetworkImage(
                          imageUrl: profileImageUrl,
                          fit: BoxFit.cover,
                          width: widget.screenWidth * 0.34,
                          height: widget.screenWidth * 0.34,
                          placeholder: (context, url) =>  Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        )
                            : Image.asset(
                          "assets/images/no pic.jpg",
                          fit: BoxFit.cover,
                          width: widget.screenWidth * 0.34,
                          height: widget.screenWidth * 0.34,
                        )),
                      ),
                    ),
                    if (widget.isShown)
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
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  profileName,
                  style: theme.bodyMedium?.copyWith(color: const Color(0xff282929)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
