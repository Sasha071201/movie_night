class User {
  final String? uid;
  final String? name;
  final String? urlProfileImage;

  const User({
    required this.uid,
    required this.name,
    required this.urlProfileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'] as String?,
        name: json['name'] as String?,
        urlProfileImage: json['urlProfileImage'] as String?,
      );

  User copyWith({
    String? uid,
    String? name,
    String? urlProfileImage,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      urlProfileImage: urlProfileImage ?? this.urlProfileImage,
    );
  }
}
