import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_alert_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/helper/app_snack_bar.dart';
import '../manager/propert_confirm/property_confirm_cubit.dart';
import '../manager/propert_confirm/property_confirm_state.dart';
import '../manager/property_pending/property_pending_cubit.dart';
import '../views/myAdvScreen.dart';

class PropertyForm4 extends StatefulWidget {
  final PropertyFormData formData;
  const PropertyForm4({super.key, required this.formData});

  @override
  State<PropertyForm4> createState() => _PropertyForm3State();
}

class _PropertyForm3State extends State<PropertyForm4> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('pending_session_id');

      if (sessionId != null) {
        await prefs.remove('pending_session_id');
        await context.read<PropertyConfirmCubit>().propertyConfirm(sessionId: sessionId);

        final state = context.read<PropertyConfirmCubit>().state;

        if (state is PropertyConfirmStateSuccess) {
          AppSnackBar.showFromTop(
            context: context,
            title: 'Success',
            message: 'تم الدفع بنجاح، سيتم نشر الإعلان.',
            contentType: ContentType.success,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyAdvertisementsPage(initialPublishedCount: 0),
            ),
          );
        } else {
          AppSnackBar.showFromTop(
            context: context,
            title: 'Error',
            message:"فشلت عملية الدفع. سيتم تعليق حجز الشقة مؤقتًا لحين إتمام الدفع.",
            contentType: ContentType.failure,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyAdvertisementsPage(initialPublishedCount: 1),
            ),
          );
        }
      }
    }
  }



  String? _pendingSessionId;
  bool _paymentLaunched = false;

  List<File> images = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => images.add(File(image.path)));
    }
  }


  void _showPaymentAlert(BuildContext context) {
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ يرجى إضافة صورة واحدة على الأقل')),
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder:
          (context) => CustomAlertDialog(
            iconPath: 'assets/images/alert.svg',
            title: 'لنشر الإعلان يجب الدفع',
            description: 'قم بالدفع لنشر اعلانك',
            confirmText: 'دفع',
            cancelText: 'إلغاء',
            onConfirm: () {
              Navigator.pop(context);
              widget.formData.images = images;
            },
            onCancel: () async {
              Navigator.pop(context);
              widget.formData.images = images;
            },
          ),
    );
  }
  Future<void> openStripeCheckout(String rawUrl) async {
    try {
      final Uri url = Uri.parse(rawUrl);

      bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        launched = await launchUrl(
          url,
          mode: LaunchMode.inAppBrowserView,
        );
      }

      if (!launched) {
        debugPrint("❌ Still couldn't launch: $url");
      }
    } catch (e) {
      debugPrint('🚫 Error launching Stripe URL: $e');
    }
  }





  Widget buildLabel(String text, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(top: screenWidth * 0.03),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: screenWidth * 0.04,
          fontFamily: Fonts.primaryFontFamily,
          color: AppColors.titleSmallColor,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('أضف صور العقار', screenWidth),
          SizedBox(height: screenHeight * 0.02),

          Center(
            child: DottedBorder(
              color: const Color(0xFFDADADA),
              strokeWidth: 1,
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              child: Container(
                width: screenWidth * 0.88,
                height: screenHeight * 0.28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    images.isEmpty
                        ? _buildEmptyUploadBox(screenWidth, screenHeight)
                        : _buildImageGrid(screenWidth),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'نشر',
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (images.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('❌ يرجى إضافة صورة واحدة على الأقل'),
                        ),
                      );
                      return;
                    }
                    final paymentUrl = await context
                        .read<PropertyPendingCubit>()
                        .postPropertyPending(property: widget.formData);
                    print('paymentUrl:$paymentUrl');
                    if (paymentUrl != null && paymentUrl.isNotEmpty) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.black.withOpacity(0.4),
                        builder:
                            (context) => CustomAlertDialog(
                              iconPath: 'assets/images/alert.svg',
                              title: 'لنشر الإعلان يجب الدفع',
                              description: 'قم بالدفع لنشر اعلانك',
                              confirmText: 'دفع',
                              cancelText: 'إلغاء',
                              onConfirm: () async {
                                final regex = RegExp(r'cs_test_[a-zA-Z0-9]+');
                                final match = regex.firstMatch(paymentUrl);
                                final sessionId = match?.group(0);

                                if (sessionId != null) {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setString('pending_session_id', sessionId);

                                  setState(() {
                                    _pendingSessionId = sessionId;
                                    _paymentLaunched = true;
                                  });

                                  await openStripeCheckout(paymentUrl);

                                } else {
                                  AppSnackBar.showFromTop(
                                    context: context,
                                    title: 'Error',
                                    message: 'لم يتم العثور على session ID في الرابط.',
                                    contentType: ContentType.failure,
                                  );
                                }
                              },
                              onCancel: () async {
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyAdvertisementsPage(
                                    initialPublishedCount: 1,
                                  )),
                                      (route) => false,
                                );
                              },
                            ),
                      );
                      AppSnackBar.showFromTop(
                        context: context,
                        title: 'Warning',
                        message: 'تم تعليق الإعلان لحين إتمام عملية الدفع',
                        contentType: ContentType.warning,
                      );
                    } else {
                      AppSnackBar.showFromTop(
                        context: context,
                        title: 'Error',
                        message:
                            ' فشل في إرسال البيانات أو لم يتم الحصول على رابط الدفع',
                        contentType: ContentType.failure,
                      );
                    }
                  },
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: CustomButton(
                  text: 'السابق',
                  backgroundColor: Colors.white,
                  textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyUploadBox(double screenWidth, double screenHeight) {
    final iconSize = screenWidth * 0.064;
    final textFontSize = screenWidth * 0.032;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Images.uploadIcon,
              width: iconSize,
              height: iconSize,
              color: Colors.grey,
            ),
            SizedBox(height: screenHeight * 0.015),
            Text('قم بسحب الصوره هنا', style: _textStyle(textFontSize)),
            Text('او', style: _textStyle(textFontSize)),
            Text('باختيار ملف', style: _textStyle(textFontSize)),
            SizedBox(height: screenHeight * 0.015),
            SizedBox(
              width: screenWidth * 0.314,
              height: screenHeight * 0.06,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  side: BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _pickImage,
                child: Text(
                  'تصفح',
                  style: TextStyle(
                    fontFamily: Fonts.primaryFontFamily,
                    fontSize: screenWidth * 0.037,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(double screenWidth) {
    final iconSize = screenWidth * 0.064;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: images.length + 1,
      itemBuilder: (_, i) {
        if (i == images.length) {
          return GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.add,
                size: iconSize,
                color: AppColors.primaryColor,
              ),
            ),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(images[i], fit: BoxFit.cover),
        );
      },
    );
  }

  TextStyle _textStyle(double size) {
    return TextStyle(
      fontFamily: Fonts.primaryFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: Colors.grey.shade600,
    );
  }
}
