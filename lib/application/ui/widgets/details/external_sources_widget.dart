import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_night/application/utils/url_launcher_helper.dart';

import '../../../../generated/l10n.dart';
import '../../../resources/resources.dart';
import '../../themes/app_text_style.dart';

enum ExternalSourcesType { facebook, twitter, instagram }

class ExternalSourcesData {
  final String source;
  final ExternalSourcesType type;
  ExternalSourcesData({
    required this.source,
    required this.type,
  });
}

class ExternalSourcesWidget extends StatelessWidget {
  final bool allIsNull;
  final List<ExternalSourcesData> data;
  const ExternalSourcesWidget({
    Key? key,
    required this.allIsNull,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !allIsNull
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).external_sources,
                style: AppTextStyle.header3,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: data.map((data) {
                    var icon = '';
                    Future Function(String)? onTap;
                    switch (data.type) {
                      case ExternalSourcesType.facebook:
                        icon = AppIcons.facebook;
                        onTap = UrlLauncherHelper.openFacebookLink;
                        break;
                      case ExternalSourcesType.twitter:
                        icon = AppIcons.twitter;
                        onTap = UrlLauncherHelper.openTwitterLink;
                        break;
                      case ExternalSourcesType.instagram:
                        icon = AppIcons.instagram;
                        onTap = UrlLauncherHelper.openInstagramLink;
                        break;
                    }
                    return data.source.isNotEmpty
                        ? InkWell(
                            onTap: () async => await onTap!(data.source),
                            child: SizedBox(
                              height: 48,
                              width: 48,
                              child: Center(
                                child: SvgPicture.asset(
                                  icon,
                                ),
                              ),
                            ))
                        : const SizedBox.shrink();
                  }).toList(),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
