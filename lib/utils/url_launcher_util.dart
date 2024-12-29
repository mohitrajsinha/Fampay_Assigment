import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static Future<void> launchUrl(String url) async {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
