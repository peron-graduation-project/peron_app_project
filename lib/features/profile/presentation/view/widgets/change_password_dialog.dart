import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import '../../manager/change password/change_password_cubit.dart';
import '../../manager/change password/change_password_state.dart';
import 'success_dialog.dart';

void showChangePasswordDialog(BuildContext parentContext) {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: parentContext,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: BlocProvider.of<ChangePasswordCubit>(parentContext),
        child: StatefulBuilder(
          builder: (context, setState) {
            var theme = Theme.of(context).textTheme;
            double screenWidth = MediaQuery.of(context).size.width;
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
              ),
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
                child: Form(
                  key: formKey,
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
                        'إنشاء كلمة مرور جديدة',
                        style: theme.titleSmall?.copyWith(
                          color: Color(0xff292828),
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.03),
                      buildPasswordField(
                        "كلمة المرور الحالية",
                        currentPasswordController,
                        obscureText1,
                        () {
                          setState(() {
                            obscureText1 = !obscureText1;
                          });
                        },
                        context,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور الحالية';
                          }
                          return null;
                        },
                      ),
                      buildPasswordField(
                        "كلمة المرور الجديدة",
                        newPasswordController,
                        obscureText2,
                        () {
                          setState(() {
                            obscureText2 = !obscureText2;
                          });
                        },
                        context,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور الجديدة';
                          }
                          return null;
                        },
                      ),
                      buildPasswordField(
                        "تأكيد كلمة المرور الجديدة",
                        confirmPasswordController,
                        obscureText3,
                        () {
                          setState(() {
                            obscureText3 = !obscureText3;
                          });
                        },
                        context,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء تأكيد كلمة المرور الجديدة';
                          }
                          if (value != newPasswordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenWidth * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 55.0),
                        child: BlocBuilder<
                          ChangePasswordCubit,
                          ChangePasswordState
                        >(
                          builder: (blocContext, state) {
                            if (state is ChangePasswordStateSuccess) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pop(dialogContext);
                                showSuccessDialog(dialogContext);
                              });
                              return SizedBox.shrink();
                            }
                            if (state is ChangePasswordStateFailure) {
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  state.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            }
                            return CustomButton(
                              isLoading: state is ChangePasswordStateLoading,
                              onPressed:
                                  state is ChangePasswordStateLoading
                                      ? null
                                      : () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<ChangePasswordCubit>(
                                            context,
                                            listen: false,
                                          ).changePassword(
                                            oldPassword:
                                                currentPasswordController.text,
                                            newPassword:
                                                newPasswordController.text,
                                            confirmPassword:
                                                confirmPasswordController.text,
                                          );
                                        }
                                      },
                              backgroundColor: AppColors.primaryColor,
                              textColor: Colors.white,
                              text:
                                  state is ChangePasswordStateLoading
                                      ? 'جاري التأكيد...'
                                      : 'تأكيد',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget buildPasswordField(
  String hint,
  TextEditingController controller,
  bool obscureText,
  VoidCallback toggleVisibility,
  BuildContext context, {
  String? Function(String?)? validator,
}) {
  double screenWidth = MediaQuery.of(context).size.width;

  return Container(
    margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 158, 156, 156)),
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: TextFormField(
      cursorColor: AppColors.primaryColor,
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
      validator: validator,
    ),
  );
}
