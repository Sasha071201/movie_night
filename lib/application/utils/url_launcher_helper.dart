import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/api_client/media_type.dart';
import 'package:movie_night/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  UrlLauncherHelper._();

  static Future openSearchLink({
    required MediaType type,
    required BuildContext context,
    required String title,
  }) async {
    final url = type != MediaType.person ? '${S.of(context).watch_online} $title' : title;
    await _launcherUrl('https://www.google.com/search?q=$url');
  }

  static Future openFacebookLink(String url) async {
    final resultUrl = 'https://www.facebook.com/$url';
    await _launcherUrl(resultUrl);
  }

  static Future openInstagramLink(String url) async {
    final resultUrl = 'https://www.instagram.com/$url/';
    await _launcherUrl(resultUrl);
  }

  static Future openTwitterLink(String url) async {
    final resultUrl = 'https://twitter.com/$url';
    await _launcherUrl(resultUrl);
  }

  static Future _launcherUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
