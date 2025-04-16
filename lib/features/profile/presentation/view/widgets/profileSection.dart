import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peron_project/core/helper/colors.dart';
import '../../manager/get profile/get_profile_cubit.dart';
import '../../manager/get profile/get_profile_state.dart';
import '../../manager/update profile/update_profile_cubit.dart';
import '../../manager/update profile/update_profile_state.dart';

class ProfileSection extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String originalFullName;

  const ProfileSection({super.key, required this.screenWidth, required this.screenHeight, required this.originalFullName});

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
                  print('ProfileSection: تم اختيار صورة: ${image.path}');
                  // استدعاء updateProfile هنا
                  BlocProvider.of<UpdateProfileCubit>(context).updateProfile(
                    profilePicture: _selectedImagePath!,
                    fullName: widget.originalFullName,
                  );
                  print('ProfileSection: تم استدعاء updateProfile');
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
    final state = context.read<GetProfileCubit>().state;
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
    print('ProfileSection: تم بناء الـ Widget');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) async {
          if (state is UpdateProfileStateSuccess) {
            print('ProfileSection: UpdateProfileStateSuccess reached!');
            // استدعاء getProfile هنا عشان تحديث البيانات في GetProfileCubit
            context.read<GetProfileCubit>().getProfile();

            if (_oldProfileImageUrl != null) {
              await CachedNetworkImage.evictFromCache(_oldProfileImageUrl!);
              print('ProfileSection: تم مسح كاش الصورة القديمة: $_oldProfileImageUrl');
            }

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث البروفايل بنجاح')),
            );
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
            print('ProfileSection: تم بناء الـ Widget - URL في الـ build: ${state is GetProfileLoaded ? state.profile.profilePictureUrl : 'Loading/Error'}');

            String profileName = "";
            String? profileImageUrl;

            if (state is GetProfileLoaded) {
              if (_oldProfileImageUrl != state.profile.profilePictureUrl) {
                _oldProfileImageUrl = state.profile.profilePictureUrl;
                print('ProfileSection: تم تحديث الـ URL القديم: $_oldProfileImageUrl');
              }
              profileName = state.profile.fullName ?? widget.originalFullName;
              profileImageUrl = state.profile.profilePictureUrl;
              print('ProfileSection: GetProfileLoaded - URL: $profileImageUrl');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      key: ValueKey(state is GetProfileLoaded ? state.profile.profilePictureUrl : null),
                      radius: widget.screenWidth * 0.15,
                      backgroundImage: _selectedImagePath != null
                          ? FileImage(File(_selectedImagePath!)) as ImageProvider
                          : null,
                      child: Stack(
                        children: [
                          if (context.read<GetProfileCubit>().state is GetProfileLoaded &&
                              (context.read<GetProfileCubit>().state as GetProfileLoaded).profile.profilePictureUrl != null &&
                              _selectedImagePath == null)
                            CachedNetworkImage(
                              imageUrl: (context.read<GetProfileCubit>().state as GetProfileLoaded).profile.profilePictureUrl!,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => CircularProgressIndicator(color: AppColors.primaryColor),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          if (_selectedImagePath != null)
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(File(_selectedImagePath!)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (context.read<GetProfileCubit>().state is GetProfileLoading && _selectedImagePath == null)
                            CircularProgressIndicator(color: AppColors.primaryColor),
                        ],
                      ),
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
                    if (context.read<GetProfileCubit>().state is GetProfileLoading)
                      Positioned.fill(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    if (context.read<GetProfileCubit>().state is GetProfileError)
                      Positioned.fill(
                        child: Center(
                          child: Text('Failed to load profile: ${(context.read<GetProfileCubit>().state as GetProfileError).message}', style: const TextStyle(color: Colors.red)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                    state is GetProfileLoaded ? state.profile.fullName ?? '' : widget.originalFullName,
                    style: theme.bodyMedium?.copyWith(color: const Color(0xff282929))),              ],
            );
          },
        ),
      ),
    );
  }
}