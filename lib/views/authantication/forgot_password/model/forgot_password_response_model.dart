class ForgotPasswordResponseModel {
  String mailAdress;
  bool isMailSended;
  String? reason;

  ForgotPasswordResponseModel({
    required this.mailAdress,
    required this.isMailSended,
    required this.reason,
  });

  ForgotPasswordResponseModel copyWith({
    String? mailAdress,
    bool? isMailSended,
    String? reason,
  }) {
    return ForgotPasswordResponseModel(
      mailAdress: mailAdress ?? this.mailAdress,
      isMailSended: isMailSended ?? this.isMailSended,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mailAdress': mailAdress,
      'isMailSended': isMailSended,
      'reason': reason,
    };
  }

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      mailAdress: json['mailAdress'] as String,
      isMailSended: json['isMailSended'] as bool,
      reason: json['reason'] as String?,
    );
  }

  @override
  String toString() =>
      "ForgotPasswordResponseModel(mailAdress: $mailAdress,isMailSended: $isMailSended,reason: $reason)";

  @override
  int get hashCode => Object.hash(mailAdress, isMailSended, reason);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForgotPasswordResponseModel &&
          runtimeType == other.runtimeType &&
          mailAdress == other.mailAdress &&
          isMailSended == other.isMailSended &&
          reason == other.reason;
}
