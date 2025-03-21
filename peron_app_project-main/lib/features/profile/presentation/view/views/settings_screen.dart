import 'package:flutter/material.dart';

import '../widgets/lang_selection_dialog.dart';
import '../widgets/rating_dialog.dart';
import '../widgets/setting_item.dart';
import 'about_us_screen.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'الاعدادات',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
