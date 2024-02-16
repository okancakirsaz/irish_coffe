class UserIdSendRequestModel {
  String? uid;

  UserIdSendRequestModel({
    this.uid,
  });

  UserIdSendRequestModel copyWith({
    String? uid,
  }) {
    return UserIdSendRequestModel(
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
    };
  }

  factory UserIdSendRequestModel.fromJson(Map<String, dynamic> json) {
    return UserIdSendRequestModel(
      uid: json['uid'] as String?,
    );
  }

  @override
  String toString() => "UserIdSendRequestModel uid:  uid)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserIdSendRequestModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid;
}
