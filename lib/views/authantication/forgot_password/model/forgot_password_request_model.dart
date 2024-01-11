class ForgotPasswordRequestModel {
  String email;

  ForgotPasswordRequestModel({
    required this.email,
  });

  ForgotPasswordRequestModel copyWith({
    String? email,
  }) {
    return ForgotPasswordRequestModel(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequestModel(
      email: json['email'] as String,
    );
  }

  @override
  String toString() => "ForgotPasswordRequestModel(email: $email)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForgotPasswordRequestModel &&
          runtimeType == other.runtimeType &&
          email == other.email;
}
