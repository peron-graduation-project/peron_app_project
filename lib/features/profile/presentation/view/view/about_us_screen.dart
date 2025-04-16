import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/about_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/helper/images.dart';
import '../../../../../core/widgets/custom_arrow_back.dart';

class AboutUs extends StatelessWidget {
  void _launchAccounts(String urlAccount) async {
    final Uri url = Uri.parse(urlAccount);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "من نحن",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        leading: CustomArrowBack(),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Images.kLogo,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            SizedBox(height: 5),
            Text(
              "بيرون",
              style: theme.titleLarge?.copyWith(
                fontSize: 28.43,
              )
            ),
            SizedBox(height: 20,),
            AboutItem(title: 'موقع الويب',  onTap: () {},),
            AboutItem(title: 'فيسبوك', onTap: () {
              _launchAccounts('https://www.facebook.com/profile.php?id=61573691399425');
            },),
            AboutItem(title: 'انستجرام', onTap: () { 
              _launchAccounts('https://www.instagram.com/pero.n98/profilecard/?igsh=MTQyc3htcDU4Nm90Ng==');
            },),
            AboutItem(title: 'تواصل معنا', onTap: () {
              _launchAccounts("http://wa.me/201119723643");
            }, ),
          ],
              ),
      ),
          );
  }
}
