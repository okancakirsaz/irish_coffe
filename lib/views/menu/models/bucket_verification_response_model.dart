class BucketVerificationResponseModel {
  bool isAllValid;
  String? errorMessage;

  BucketVerificationResponseModel({
    required this.isAllValid,
    required this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'isAllValid': isAllValid,
      'errorMessage': errorMessage,
    };
  }

  factory BucketVerificationResponseModel.fromJson(Map<String, dynamic> json) {
    return BucketVerificationResponseModel(
      isAllValid: json['isAllValid'] as bool,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  @override
  String toString() =>
      "BucketVerificationResponseModel(isAllValid: $isAllValid,errorMessage: $errorMessage)";

  @override
  int get hashCode => Object.hash(isAllValid, errorMessage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BucketVerificationResponseModel &&
          runtimeType == other.runtimeType &&
          isAllValid == other.isAllValid &&
          errorMessage == other.errorMessage;
}
