class UserSettingsModel {
  String? photoUrl;
  String? name;
  String? email;
  String? phoneNumber;
  bool? isAnonym;

  UserSettingsModel({
    this.photoUrl,
    this.name,
    this.email,
    this.phoneNumber,
    this.isAnonym,
  });

  UserSettingsModel copyWith({
    String? photoUrl,
    String? name,
    String? email,
    String? phoneNumber,
    bool? isAnonym,
  }) {
    return UserSettingsModel(
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAnonym: isAnonym ?? this.isAnonym,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photoUrl': photoUrl,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isAnonym': isAnonym,
    };
  }

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      photoUrl: json['photoUrl'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isAnonym: json['isAnonym'] as bool?,
    );
  }

  @override
  String toString() =>
      "UserSettingsModel(photoUrl: $photoUrl,name: $name,email: $email,phoneNumber: $phoneNumber,isAnonym: $isAnonym)";

  @override
  int get hashCode => Object.hash(photoUrl, name, email, phoneNumber, isAnonym);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsModel &&
          runtimeType == other.runtimeType &&
          photoUrl == other.photoUrl &&
          name == other.name &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          isAnonym == other.isAnonym;
}
