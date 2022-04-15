import 'dart:math';

import 'package:flutter/material.dart';

import 'package:movie_night/application/ui/widgets/dialog_widget.dart';
import 'package:movie_night/application/ui/widgets/text_button_widget.dart';
import 'package:movie_night/application/ui/widgets/text_field_widget.dart';

import '../../../generated/l10n.dart';
import '../../domain/entities/review.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_style.dart';
import 'cached_network_image_widget.dart';

class ReviewsSliverWidget extends StatelessWidget {
  final Stream<List<Review>>? reviews;
  final String Function(DateTime date) timeAgoFromDate;
  final void Function(String? reviewId) deleteReview;
  final Future<void> Function(Review review) sendComplaintToReview;
  final TextEditingController complaintReviewTextController;

  const ReviewsSliverWidget({
    Key? key,
    required this.reviews,
    required this.timeAgoFromDate,
    required this.deleteReview,
    required this.sendComplaintToReview,
    required this.complaintReviewTextController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reviews != null
        ? StreamBuilder<List<Review>>(
            stream: reviews,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final reviews = snapshot.data!;
                  if (reviews.isNotEmpty) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final int itemIndex = reviews.length - 1 - index ~/ 2;
                          if (index.isEven) {
                            return _ReviewItemWidget(
                              key: ValueKey(reviews[itemIndex].hashCode),
                              review: reviews[itemIndex],
                              timeAgoFromDate: timeAgoFromDate,
                              deleteReview: deleteReview,
                              sendComplaintToReview: sendComplaintToReview,
                              complaintReviewTextController:
                                  complaintReviewTextController,
                            );
                          }
                          return const Divider(
                            height: 1,
                            color: AppColors.colorSecondaryText,
                          );
                        },
                        childCount: max(0, reviews.length * 2 - 1),
                        findChildIndexCallback: (key) {
                          final valueKey = key as ValueKey<int>;
                          final index = reviews.indexWhere(
                              (element) => element.hashCode == valueKey.value);
                          return reviews.length - 1 - index;
                        },
                      ),
                    );
                  }
                  return const _EmptyTextWidget();
                }
                return const _EmptyTextWidget();
              }
              return const _CircularProgressIndicatorWidget();
            },
          )
        : const _ErrorTextWidget();
  }
}

class _CircularProgressIndicatorWidget extends StatelessWidget {
  const _CircularProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.colorMainText,
        ),
      ),
    );
  }
}

class _EmptyTextWidget extends StatelessWidget {
  const _EmptyTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          S.of(context).empty_write_review_first,
          style: AppTextStyle.header3,
        ),
      ),
    );
  }
}

class _ErrorTextWidget extends StatelessWidget {
  const _ErrorTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          S.of(context).you_cannot_write_reviews_here_yet,
          style: AppTextStyle.header3,
        ),
      ),
    );
  }
}

class _ReviewItemWidget extends StatelessWidget {
  final Review review;
  final String Function(DateTime date) timeAgoFromDate;
  final void Function(String? reviewId) deleteReview;
  final Future<void> Function(Review review) sendComplaintToReview;
  final TextEditingController complaintReviewTextController;

  const _ReviewItemWidget({
    Key? key,
    required this.review,
    required this.timeAgoFromDate,
    required this.deleteReview,
    required this.sendComplaintToReview,
    required this.complaintReviewTextController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: CachedNetworkImageWidget(
                  imageUrl: review.avatarUrl,
                  width: 60,
                  height: 60,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name != null && review.name!.isNotEmpty
                          ? review.name!
                          : S.of(context).unknown,
                      style: AppTextStyle.medium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      timeAgoFromDate(review.date),
                      style: AppTextStyle.small.copyWith(
                        color: AppColors.colorSecondaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (review.isMine) ...[
                IconButton(
                  onPressed: () => deleteReview(review.id),
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.colorSecondary,
                  ),
                ),
              ] else ...[
                PopupMenuButton(
                  color: AppColors.colorPrimary,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'complain',
                      child: Text(
                        S.of(context).complain,
                        style: AppTextStyle.button,
                      ),
                    ),
                  ],
                  onSelected: (String value) async {
                    if (value.compareTo('complain') == 0) {
                      DialogWidget.show(
                        context: context,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).complain,
                              style: AppTextStyle.header2,
                            ),
                            const SizedBox(height: 16),
                            TextFieldWidget(
                              controller: complaintReviewTextController,
                              hintText: S.of(context).text_of_complaint,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              enableSuggestions: true,
                              maxLines: 1,
                              onSubmitted: (text) async {
                                await sendComplaintToReview(review);
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(height: 28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButtonWidget(
                                  child: Text(
                                    S.of(context).cancel,
                                    style: AppTextStyle.button.copyWith(
                                      color: AppColors.colorSecondary,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButtonWidget(
                                  child: Text(
                                    S.of(context).send,
                                    style: AppTextStyle.button.copyWith(
                                      color: AppColors.colorSecondary,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await sendComplaintToReview(review);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ).then((value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        complaintReviewTextController.clear();
                      });
                    }
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.review,
            style: AppTextStyle.small,
          ),
        ],
      ),
    );
  }
}
