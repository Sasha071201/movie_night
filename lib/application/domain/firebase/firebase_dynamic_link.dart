import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';

enum FirebaseDynamicLinkType { movie, tv, person, user }

class FirebaseDynamicLinkService {
  const FirebaseDynamicLinkService._();

  static Future<String> createDynamicLink({
    required FirebaseDynamicLinkType type,
    required String id,
    required String title,
    required String description,
    bool short = true,
  }) async {
    String linkMessage;

    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: "https://movienightsstreltsov.page.link",
      link: Uri.parse("https://www.movienightsstreltsov.com/${type.name}?id=$id"),
      androidParameters: const AndroidParameters(
        packageName: "com.sstreltsov.movie_night",
      ),
      iosParameters: IOSParameters(
        bundleId: "com.sstreltsov.movie-night",
        fallbackUrl: Uri.parse('https://t.me/+xKKzRO6CUak0ZTRi'),
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title.isEmpty ? null : title,
        description: description.isEmpty ? null : description,
      ),
    );

    Uri url;
    if (short) {
      final shortLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
      url = shortLink.shortUrl;
    } else {
      url = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    }

    linkMessage = url.toString();
    return linkMessage;
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      _openDeepLink(deepLink, context);
    }).onError((error) {
      log(error.toString());
    });

    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final deepLink = data?.link;
    if (deepLink != null) {
      _openDeepLink(deepLink, context);
    } else {
      return;
    }
  }

  static void _openDeepLink(Uri deepLink, BuildContext context) {
    bool isMovie = deepLink.pathSegments.contains(FirebaseDynamicLinkType.movie.name);
    bool isTv = deepLink.pathSegments.contains(FirebaseDynamicLinkType.tv.name);
    bool isPerson = deepLink.pathSegments.contains(FirebaseDynamicLinkType.person.name);
    bool isUser = deepLink.pathSegments.contains(FirebaseDynamicLinkType.user.name);
    if (isMovie || isTv || isPerson || isUser) {
      try {
        String? id = deepLink.queryParameters['id'];
        if (id == null) return;

        if (isMovie) {
          Navigator.of(context).pushNamed(
            Screens.movieDetails,
            arguments: int.parse(id),
          );
        } else if (isTv) {
          Navigator.of(context).pushNamed(
            Screens.tvShowDetails,
            arguments: int.parse(id),
          );
        } else if (isPerson) {
          Navigator.of(context).pushNamed(
            Screens.actorDetails,
            arguments: int.parse(id),
          );
        } else if (isUser) {
          Navigator.of(context).pushNamed(
            Screens.userDetails,
            arguments: id,
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
