import 'package:flutter/material.dart';
import 'package:movie_night/application/domain/entities/user.dart';
import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/generated/l10n.dart';

class UserItemWidget extends StatelessWidget {
  const UserItemWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(Screens.userDetails, arguments: user.uid),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: Image.network(
          user.urlProfileImage ?? '',
          width: 45,
          height: 45,
          fit: BoxFit.cover,
          errorBuilder: (context, object, stacktrace) => Image.asset(
            AppImages.placeholder,
            width: 45,
            height: 45,
            color: AppColors.colorMainText,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        user.name ?? S.of(context).unknown,
        style: AppTextStyle.small,
      ),
    );
  }
}
