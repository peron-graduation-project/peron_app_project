import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import '../../../../authentication/presentation/view/widgets/phone_field.dart';
import '../../manager/update profile/update_profile_cubit.dart';
import '../../manager/update profile/update_profile_state.dart';

Future<String?> showChangePhoneNumberDialog(BuildContext context, String phoneNumber) async {
  TextEditingController phoneNumberController = TextEditingController(text: phoneNumber);

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      var theme=Theme.of(context).textTheme;
      double screenWidth = MediaQuery.of(context).size.width;
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.015),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff0F7757),
                        ),
                        child: Icon(
                          Icons.close,
                          size: screenWidth * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                      'تغير رقم الهاتف',
                      style: theme.titleSmall?.copyWith(color: Color(0xff292828))
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  PhoneFieldInput(controller: phoneNumberController),
                  SizedBox(height: screenWidth * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55.0),
                    child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: state is UpdateProfileStateLoading,
                          onPressed: state is UpdateProfileStateLoading
                              ? null
                              : () {
                            final newPhoneNumber = phoneNumberController.text.trim();
                            if (newPhoneNumber.isNotEmpty) {
                              BlocProvider.of<UpdateProfileCubit>(context, listen: false)
                                  .updateProfile(
                                profilePicture: '',
                                fullName: '',
                                phoneNumber: newPhoneNumber,
                              ).then((_) {
                                Navigator.pop(context, newPhoneNumber);
                              });
                            }
                          },
                          backgroundColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          text: state is UpdateProfileStateLoading
                              ? 'جاري التأكيد...'
                              : 'تأكيد',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
