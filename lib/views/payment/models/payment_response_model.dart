class PaymentResponseModel {
  bool isSuccess;
  String? errorMessage;

  PaymentResponseModel({
    required this.isSuccess,
    required this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'errorMessage': errorMessage,
    };
  }

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      isSuccess: json['isSuccess'] as bool,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  @override
  String toString() =>
      "PaymentResponseModel(isSuccess: $isSuccess,errorMessage: $errorMessage)";

  @override
  int get hashCode => Object.hash(isSuccess, errorMessage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentResponseModel &&
          runtimeType == other.runtimeType &&
          isSuccess == other.isSuccess &&
          errorMessage == other.errorMessage;
}
