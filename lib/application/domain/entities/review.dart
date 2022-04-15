import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String? id;
  final String? userId;
  final String? name;
  final String? avatarUrl;
  final DateTime date;
  final String review;
  final bool isMine;
  const Review({
    this.id,
    this.userId,
    this.name,
    this.avatarUrl,
    required this.date,
    required this.review,
    this.isMine = false,
  });

  @override
  List<Object?> get props {
    return [
      userId,
      name,
      avatarUrl,
      date,
      review,
    ];
  }
}
