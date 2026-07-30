import 'package:url_launcher/url_launcher.dart';

class AppLauncher {
  static Future<void> open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> email(String address) async {
    await open('mailto:$address');
  }
}
