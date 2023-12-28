class CurrentlyInIrishModel {
  String name;
  String gender;
  bool isAnonym;
  String token;
  int index;
  String? profileImage;

  CurrentlyInIrishModel({
    required this.name,
    required this.gender,
    required this.isAnonym,
    required this.token,
    required this.index,
    required this.profileImage,
  });

  CurrentlyInIrishModel copyWith({
    String? name,
    String? gender,
    bool? isAnonym,
    String? token,
    String? profileImage,
  }) {
    return CurrentlyInIrishModel(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      isAnonym: isAnonym ?? this.isAnonym,
      token: token ?? this.token,
      index: index,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'isAnonym': isAnonym,
      'token': token,
      'index': index,
      'profileImage': profileImage,
    };
  }

  factory CurrentlyInIrishModel.fromJson(Map<String, dynamic> json) {
    return CurrentlyInIrishModel(
      name: json['name'] as String,
      gender: json['gender'] as String,
      isAnonym: json['isAnonym'] as bool,
      token: json['token'] as String,
      index: json['index'] as int,
      profileImage: json['profileImage'] as String?,
    );
  }

  @override
  String toString() =>
      "CurrentlyInIrishModel(name: $name,gender: $gender,isAnonym: $isAnonym,token: $token,profileImage: $profileImage, index:$index)";

  @override
  int get hashCode => Object.hash(name, gender, isAnonym, token, profileImage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentlyInIrishModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          gender == other.gender &&
          isAnonym == other.isAnonym &&
          token == other.token &&
          profileImage == other.profileImage;
}
