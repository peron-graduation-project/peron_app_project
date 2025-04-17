import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/features/profile/presentation/manager/app%20rating/send%20app%20rating/send_app_rating_cubit.dart';
import 'package:peron_project/features/profile/presentation/manager/app%20rating/send%20app%20rating/send_app_rating_state.dart';

import '../../../../../core/widgets/custom_button.dart';

void showRatingDialog(BuildContext context) {
  int selectedRating = 0;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      double screenWidth = MediaQuery.of(dialogContext).size.width;
      var theme = Theme.of(dialogContext).textTheme;

      return BlocListener<SendAppRatingCubit, SendAppRatingState>(
        listener: (context, state) {
          if (state is SendAppRatingStateSuccess) {
            Navigator.pop(dialogContext);
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              SnackBar(content: Text('تم إرسال التقييم بنجاح')),
            );
          } else if (state is SendAppRatingStateFailure) {
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: StatefulBuilder(
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
                        onTap: () => Navigator.pop(dialogContext),
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
                    SvgPicture.asset(Images.rating),
                    Text(
                      ' هل أنت مستمتع باستخدام ابليكيشن بيرون؟',
                      style: theme.bodyMedium?.copyWith(color: Color(0xff292828)),
                    ),
                    Text(
                      'رأيك يهمنا فشاركنا تقييمك',
                      style: theme.displayMedium?.copyWith(
                        color: Color(0xff818181),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRating = index + 1;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              selectedRating > index
                                  ? Icons.star
                                  : Icons.star_border,
                              color: AppColors.primaryColor,
                              size: 25,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<SendAppRatingCubit, SendAppRatingState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: state is SendAppRatingStateLoading ? 'جاري الإرسال...' : 'إرسال التقييم',
                                isLoading: state is SendAppRatingStateLoading,
                                textColor: Colors.white,
                                backgroundColor: AppColors.primaryColor,
                                onPressed:  selectedRating == 0
                                    ? null
                                    : () {
                                  BlocProvider.of<SendAppRatingCubit>(dialogContext)
                                      .sendAppRating(star: selectedRating);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
