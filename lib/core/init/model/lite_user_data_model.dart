class LiteUserDataModel {
  String? token;
  String? uid;
  String? name;
  String? profileImage;
  String? gender;

  LiteUserDataModel({
    this.token,
    this.uid,
    this.name,
    this.profileImage,
    this.gender,
  });

  LiteUserDataModel copyWith({
    String? token,
    String? uid,
    String? name,
    String? profileImage,
    String? gender,
  }) {
    return LiteUserDataModel(
      token: token ?? this.token,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'uid': uid,
      'name': name,
      'profileImage': profileImage,
      'gender': gender,
    };
  }

  factory LiteUserDataModel.fromJson(Map<String, dynamic> json) {
    return LiteUserDataModel(
      token: json['token'] as String?,
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      gender: json['gender'] as String?,
    );
  }

  @override
  String toString() =>
      "LiteUserDataModel(token: $token,name: $name,profileImage: $profileImage,gender: $gender)";

  @override
  int get hashCode => Object.hash(token, name, profileImage, gender);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiteUserDataModel &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          name == other.name &&
          profileImage == other.profileImage &&
          gender == other.gender;
}
