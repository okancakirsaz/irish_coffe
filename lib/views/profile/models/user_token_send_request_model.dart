class UserTokenSendRequestModel {
  String? userToken;

  UserTokenSendRequestModel({
    this.userToken,
  });

  UserTokenSendRequestModel copyWith({
    String? userToken,
  }) {
    return UserTokenSendRequestModel(
      userToken: userToken ?? this.userToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userToken': userToken,
    };
  }

  factory UserTokenSendRequestModel.fromJson(Map<String, dynamic> json) {
    return UserTokenSendRequestModel(
      userToken: json['userToken'] as String?,
    );
  }

  @override
  String toString() => "UserTokenSendRequestModel(userToken: $userToken)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTokenSendRequestModel &&
          runtimeType == other.runtimeType &&
          userToken == other.userToken;
}
