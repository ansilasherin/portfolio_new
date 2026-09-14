import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLauncher {
  static Future<void> open(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Could not launch url: $url, error: $e');
    }
  }

  static Future<void> email(String address) async {
    await open('mailto:$address');
  }
}
