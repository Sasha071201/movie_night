import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/inkwell_material_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        leading: const BackButton(color: AppColors.colorSecondary),
        title: Text(
          'Subscription',
          style: AppTextStyle.header3,
        ),
      ),
      body: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _YourSubscriptionText(),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _AboutSubscriptionWidget(),
              ),
              const SizedBox(height: 32),
              _ButtonPriceWidget(
                title: '1 month',
                price: '1',
                onPressed: () {},
              ),
              const SizedBox(height: 1),
              _ButtonPriceWidget(
                price: '2',
                title: 'Forever',
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              const _GooglePlayStoreWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _GooglePlayStoreWidget extends StatelessWidget {
  const _GooglePlayStoreWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              S
                  .of(context)
                  .you_can_cancel_your_subscription_at_any_time_in_your_play_store,
              textAlign: TextAlign.center,
              style: AppTextStyle.subheader,
            ),
            const SizedBox(height: 2),
            Text(
              S.of(context).this_purchase_can_only_be_used_on_android_system,
              textAlign: TextAlign.center,
              style: AppTextStyle.subheader2.copyWith(
                color: AppColors.colorSecondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonPriceWidget extends StatelessWidget {
  final String title;
  final String price;
  final void Function() onPressed;
  const _ButtonPriceWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellMaterialWidget(
      borderRadius: 0,
      color: AppColors.colorSplash,
      onTap: onPressed,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.colorPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.header3,
            ),
            Text(
              '$price \$',
              style: AppTextStyle.header2
                  .copyWith(color: AppColors.colorSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSubscriptionWidget extends StatelessWidget {
  const _AboutSubscriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _PlanDescriptionWidget(
          crossAxisAlignment: CrossAxisAlignment.start,
          title: 'FREE',
          colorTitle: AppColors.colorSecondaryText,
          listData: [
            S.of(context).there_are_ads,
          ],
        ),
        Container(
          height: 77,
          width: 1,
          color: AppColors.colorMainText,
        ),
        _PlanDescriptionWidget(
          crossAxisAlignment: CrossAxisAlignment.end,
          title: 'Premium',
          colorTitle: AppColors.colorSecondary,
          listData: [
            S.of(context).no_ads,
          ],
        ),
      ],
    );
  }
}

class _PlanDescriptionWidget extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String title;
  final List<String> listData;
  final Color colorTitle;
  const _PlanDescriptionWidget({
    Key? key,
    required this.crossAxisAlignment,
    required this.title,
    required this.listData,
    required this.colorTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: AppTextStyle.header2.copyWith(
            color: colorTitle,
          ),
        ),
        for (var i = 0; i < listData.length; i++) ...[
          const SizedBox(height: 16),
          Text(
            listData[i],
            style: AppTextStyle.header3,
          ),
        ]
      ],
    );
  }
}

class _YourSubscriptionText extends StatelessWidget {
  const _YourSubscriptionText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Your  subscription',
            style: AppTextStyle.header3.copyWith(
              color: AppColors.colorMainText,
            ),
          ),
          TextSpan(
            text: ' FREE',
            style: AppTextStyle.header2.copyWith(
              color: AppColors.colorSecondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
