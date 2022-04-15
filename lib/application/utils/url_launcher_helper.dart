import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  UrlLauncherHelper._();

  static Future openLink(String url) async => await _launcherUrl(url);

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

  static Future _launcherUrl(String url, [bool inApp = true]) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,   //iOS
        forceWebView: inApp,    //android
        enableJavaScript: true, //android
      );
    }
  }
}
