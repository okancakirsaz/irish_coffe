class ForgotPasswordResponseModel {
  String email;
  bool isMailSended;
  String? reason;

  ForgotPasswordResponseModel({
    required this.email,
    required this.isMailSended,
    required this.reason,
  });

  ForgotPasswordResponseModel copyWith({
    String? email,
    bool? isMailSended,
    String? reason,
  }) {
    return ForgotPasswordResponseModel(
      email: email ?? this.email,
      isMailSended: isMailSended ?? this.isMailSended,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'isMailSended': isMailSended,
      'reason': reason,
    };
  }

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      email: json['email'] as String,
      isMailSended: json['isMailSended'] as bool,
      reason: json['reason'] as String?,
    );
  }

  @override
  String toString() =>
      "ForgotPasswordResponseModel(email: $email,isMailSended: $isMailSended,reason: $reason)";

  @override
  int get hashCode => Object.hash(email, isMailSended, reason);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForgotPasswordResponseModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          isMailSended == other.isMailSended &&
          reason == other.reason;
}
