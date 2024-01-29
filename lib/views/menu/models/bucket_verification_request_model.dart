class BucketVerificationRequestModel {
  List<String> idList;

  BucketVerificationRequestModel({
    required this.idList,
  });

  Map<String, dynamic> toJson() {
    return {
      'idList': idList,
    };
  }

  factory BucketVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    return BucketVerificationRequestModel(
      idList:
          (json['idList'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  @override
  String toString() => "BucketVerificationRequestModel(idList: $idList)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BucketVerificationRequestModel &&
          runtimeType == other.runtimeType &&
          idList == other.idList;
}
