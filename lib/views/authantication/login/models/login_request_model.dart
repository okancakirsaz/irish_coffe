class LoginRequestModel {
  String mail;
  String password;

  LoginRequestModel({
    required this.mail,
    required this.password,
  });

  LoginRequestModel copyWith({
    String? mail,
    String? password,
  }) {
    return LoginRequestModel(
      mail: mail ?? this.mail,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': mail,
      'password': password,
    };
  }

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      mail: json['email'] as String,
      password: json['password'] as String,
    );
  }

  @override
  String toString() => "LoginRequestModel(mail: $mail,password: $password)";

  @override
  int get hashCode => Object.hash(mail, password);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginRequestModel &&
          runtimeType == other.runtimeType &&
          mail == other.mail &&
          password == other.password;
}
