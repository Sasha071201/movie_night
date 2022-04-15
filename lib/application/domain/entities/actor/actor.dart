import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_night/application/domain/entities/actor/popular_actors.dart';

part 'actor.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Actor extends Equatable {
  final bool? adult;
  final int? gender;
  final int? id;
  final List<KnownFor>? knownFor;
  final String? knownForDepartment;
  final String? name;
  final double? popularity;
  final String? profilePath;
  const Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
  });

  Map<String, dynamic> toJson() => _$ActorToJson(this);

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  @override
  List<Object?> get props {
    return [
      adult,
      gender,
      id,
      knownFor,
      knownForDepartment,
      name,
      popularity,
      profilePath,
    ];
  }
}
