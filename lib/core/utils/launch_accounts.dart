import 'package:url_launcher/url_launcher.dart';

class LaunchAccounts{
 static void launchAccounts(String urlAccount) async {
    final Uri url = Uri.parse(urlAccount);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}