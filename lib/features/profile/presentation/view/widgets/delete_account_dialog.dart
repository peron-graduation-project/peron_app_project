import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import '../../../../../core/navigator/page_routes_name.dart';
import 'package:peron_project/features/profile/presentation/manager/delete%20account/delete_account_cubit.dart';
import '../../manager/delete account/delete_account_state.dart';

void showDeleteAccountDialog(BuildContext settingsContext) {
  showDialog(
    context: settingsContext,
    barrierDismissible: false,
    builder: (dialogContext) {
      var theme = Theme.of(dialogContext).textTheme;
      double screenWidth = MediaQuery.of(dialogContext).size.width;
      return BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
        builder: (blocContext, state) {
          if (state is DeleteAccountSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(dialogContext);
              Navigator.pushNamedAndRemoveUntil(
                blocContext,
                PageRouteName.afterExit,
                    (route) => false,
              );
            });
            return SizedBox.shrink();
          }

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
                      SvgPicture.asset(
                        Images.deleteAccount,
                        color: state is DeleteAccountLoading ? Colors.grey : null,
                      ),
                      Text(
                        state is DeleteAccountLoading
                            ? 'جاري حذف الحساب...'
                            : 'هل تريد حذف الحساب بالفعل؟',
                        textAlign: TextAlign.center,
                        style: theme.bodyMedium?.copyWith(
                            color: state is DeleteAccountLoading
                                ? Colors.grey
                                : Color(0xff292828)),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              isLoading: state is DeleteAccountLoading,
                              textColor: Colors.white,
                              text: 'حذف',
                              backgroundColor: AppColors.primaryColor,
                              onPressed: state is DeleteAccountLoading
                                  ? null
                                  : () {
                                BlocProvider.of<DeleteAccountCubit>(dialogContext).deleteAccount();
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              textColor: AppColors.primaryColor,
                              text: 'إلغاء',
                              backgroundColor: Colors.white,
                              borderColor: AppColors.primaryColor,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                      if (state is DeleteAccountFailure)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
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
    },
  );
}