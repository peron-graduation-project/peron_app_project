import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

import '../widgets/lang_selection_dialog.dart';
import '../widgets/rating_dialog.dart';
import '../widgets/setting_item.dart';
import 'about_us_screen.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),

                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "الاعدادات",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.titleSmallColor,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.chevron_left,
                              size: isSmallScreen ? 20 : 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                SettingsItem(
                  title: 'اللغة',
                  icon: Icons.language,
                  showArrow: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LanguageSelectionDialog();
                      },
                    );
                  },
                  isDeleteAccount: null,
                ),

                SettingsItem(
                  title: 'قم بتقييمنا',
                  icon: Icons.star_border,
                  showArrow: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RatingDialog();
                      },
                    );
                  },
                  isDeleteAccount: null,
                ),

                SettingsItem(
                  title: 'من نحن',
                  icon: Icons.info_outline,
                  showArrow: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUs()),
                    );
                  },
                  isDeleteAccount: null,
                ),

                SettingsItem(
                  title: 'تحتاج إلي المساعدة؟',
                  icon: Icons.help_outline,
                  showArrow: true,
                  onTap: () {},
                  isDeleteAccount: null,
                ),

                SettingsItem(
                  title: 'حذف الحساب',
                  icon: Icons.delete_outline,
                  showArrow: false,
                  isDeleteAccount: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
