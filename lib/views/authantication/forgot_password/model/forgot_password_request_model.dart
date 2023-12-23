class ForgotPasswordRequestModel {
  String mailAdress;

  ForgotPasswordRequestModel({
    required this.mailAdress,
  });

  ForgotPasswordRequestModel copyWith({
    String? mailAdress,
  }) {
    return ForgotPasswordRequestModel(
      mailAdress: mailAdress ?? this.mailAdress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mailAdress': mailAdress,
    };
  }

  factory ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequestModel(
      mailAdress: json['mailAdress'] as String,
    );
  }

  @override
  String toString() => "ForgotPasswordRequestModel(mailAdress: $mailAdress)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForgotPasswordRequestModel &&
          runtimeType == other.runtimeType &&
          mailAdress == other.mailAdress;
}
