class UserSettingsModel {
  String? photoUrl;
  String? name;
  String? mail;
  String? phoneNumber;
  bool? isAnonym;

  UserSettingsModel({
    this.photoUrl,
    this.name,
    this.mail,
    this.phoneNumber,
    this.isAnonym,
  });

  UserSettingsModel copyWith({
    String? photoUrl,
    String? name,
    String? mail,
    String? phoneNumber,
    bool? isAnonym,
  }) {
    return UserSettingsModel(
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      mail: mail ?? this.mail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAnonym: isAnonym ?? this.isAnonym,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photoUrl': photoUrl,
      'name': name,
      'mail': mail,
      'phoneNumber': phoneNumber,
      'isAnonym': isAnonym,
    };
  }

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      photoUrl: json['photoUrl'] as String?,
      name: json['name'] as String?,
      mail: json['mail'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isAnonym: json['isAnonym'] as bool?,
    );
  }

  @override
  String toString() =>
      "UserSettingsModel(photoUrl: $photoUrl,name: $name,mail: $mail,phoneNumber: $phoneNumber,isAnonym: $isAnonym)";

  @override
  int get hashCode => Object.hash(photoUrl, name, mail, phoneNumber, isAnonym);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsModel &&
          runtimeType == other.runtimeType &&
          photoUrl == other.photoUrl &&
          name == other.name &&
          mail == other.mail &&
          phoneNumber == other.phoneNumber &&
          isAnonym == other.isAnonym;
}
