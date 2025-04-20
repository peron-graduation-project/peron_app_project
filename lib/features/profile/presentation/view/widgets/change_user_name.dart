import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import '../../../../../core/widgets/build_text_form_field.dart';
import '../../manager/update profile/update_profile_cubit.dart';
import '../../manager/update profile/update_profile_state.dart';

Future<String?> showChangeUserNameDialog(BuildContext context, String currentName) async {
  TextEditingController userNameController = TextEditingController(text: currentName);

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
                      'تغير إسم المستخدم',
                      style: theme.titleSmall?.copyWith(color: Color(0xff292828))
                  ),
                  SizedBox(height: screenWidth * 0.03),
                  buildTextField("إسم المستخدم", TextInputType.name, controller: userNameController),
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
                            final newUserName = userNameController.text.trim();
                            if (newUserName.isNotEmpty) {
                              // استدعي الـ Cubit لتحديث الاسم هنا
                              BlocProvider.of<UpdateProfileCubit>(context, listen: false)
                                  .updateProfile(
                                profilePicture: '',
                                fullName: newUserName,
                              ).then((_) {
                                // بعد التحديث بنجاح، ارجع بالاسم الجديد
                                Navigator.pop(context, newUserName);
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
Widget buildPasswordField(
    String hint,
    TextEditingController controller,
    bool obscureText,
    VoidCallback toggleVisibility,
    BuildContext context,
    ) {
  double screenWidth = MediaQuery.of(context).size.width;

  return Container(
    margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 158, 156, 156)),
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black54),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.045,
          color: Colors.black54,
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.black54,
          size: screenWidth * 0.06,
        ),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black54,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    ),
  );
}