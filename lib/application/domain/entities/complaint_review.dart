class ComplaintReview {
  final String reviewId;
  final String accusedUserId;
  final String? complainingUserId;
  final String complaintMessage;
  final String reviewMessage;

  ComplaintReview({
    required this.reviewId,
    required this.accusedUserId,
    this.complainingUserId,
    required this.complaintMessage,
    required this.reviewMessage,
  });
}
