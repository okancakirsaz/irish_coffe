class UserDataModel {
  String? eMail;
  String? password;
  String name;
  String token;
  String? profileImage;
  String? phoneNumber;

  UserDataModel({
    this.eMail,
    this.password,
    required this.token,
    required this.profileImage,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'e_mail': eMail,
      'password': password,
      'token': token,
      'name': name,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      eMail: json['e_mail'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String,
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
    );
  }

  @override
  String toString() =>
      "UserDataModel(eMail: $eMail,password: $password,token: $token, phone number: $phoneNumber)";

  @override
  int get hashCode =>
      Object.hash(eMail, password, token, name, phoneNumber, profileImage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModel &&
          runtimeType == other.runtimeType &&
          eMail == other.eMail &&
          password == other.password &&
          token == other.token &&
          profileImage == other.profileImage &&
          name == other.name &&
          phoneNumber == other.phoneNumber;
}
