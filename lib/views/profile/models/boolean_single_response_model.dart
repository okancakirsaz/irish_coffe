class BooleanSingleResponseModel {
  bool? isSuccess;

  BooleanSingleResponseModel({
    this.isSuccess,
  });

  BooleanSingleResponseModel copyWith({
    bool? isSuccess,
  }) {
    return BooleanSingleResponseModel(
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
    };
  }

  factory BooleanSingleResponseModel.fromJson(Map<String, dynamic> json) {
    return BooleanSingleResponseModel(
      isSuccess: json['isSuccess'] as bool?,
    );
  }

  @override
  String toString() => "BooleanSingleResponseModel(isSuccess: $isSuccess)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooleanSingleResponseModel &&
          runtimeType == other.runtimeType &&
          isSuccess == other.isSuccess;
}
