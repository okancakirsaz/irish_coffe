class CurrentlyInIrishModel {
  String name;
  String gender;
  bool isAnonym;
  String token;
  String uid;
  String timestamp;
  String? profileImage;

  CurrentlyInIrishModel({
    required this.name,
    required this.gender,
    required this.isAnonym,
    required this.token,
    required this.uid,
    required this.timestamp,
    required this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'isAnonym': isAnonym,
      'token': token,
      'uid': uid,
      'timestamp': timestamp,
      'profileImage': profileImage,
    };
  }

  factory CurrentlyInIrishModel.fromJson(Map<String, dynamic> json) {
    return CurrentlyInIrishModel(
      name: json['name'] as String,
      gender: json['gender'] as String,
      isAnonym: json['isAnonym'] as bool,
      token: json['token'] as String,
      uid: json['uid'] as String,
      timestamp: json['timestamp'] as String,
      profileImage: json['profileImage'] as String?,
    );
  }

  @override
  String toString() =>
      "CurrentlyInIrishModel(name: $name,gender: $gender,isAnonym: $isAnonym,id: $uid,profileImage: $profileImage)";

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
